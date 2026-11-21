#!/usr/bin/env python3
"""
lc_cookie.py - Manage the LeetCode session used by `./lc submit`.

The session is discovered automatically, in order:
  1. $LEETCODE_COOKIE / $LEETCODE_SESSION
  2. ~/.lc/leetcode/user.json (cache, also used by the VS Code extension)
  3. LeetCode extension state in VS Code / Cursor / Windsurf
  4. Chrome's cookie store (stay logged in to leetcode.com in Chrome)
Expired sources are skipped; the first valid session is cached in (2).

Usage:
  ./lc cookie              Show current sign-in status
  ./lc cookie '<cookie>'   Save a cookie from browser DevTools and verify it
"""

import glob
import hashlib
import http.cookiejar
import json
import os
import shutil
import sqlite3
import subprocess
import sys
import tempfile
import time
import urllib.error
import urllib.request

from lc_common import (BASE_URL, GRAPHQL_URL, USER_AGENT, die,
                       graphql_request, ssl_context)

# Session cache written by vsc-leetcode-cli (used by the VS Code extension)
CLI_SESSION = "~/.lc/leetcode/user.json"

# Editor global-state databases that may hold the LeetCode extension cookie
STATE_DBS = [
    f"~/Library/Application Support/{app}/User/globalStorage/state.vscdb"
    for app in ("Code", "Cursor", "Windsurf")
]

CHROME_DIR = "~/Library/Application Support/Google/Chrome"
CHROME_EPOCH_OFFSET = 11644473600  # seconds between 1601-01-01 and 1970-01-01
SESSION_KEYS = ("LEETCODE_SESSION", "csrftoken")


def parse_cookies(raw):
    cookies = {}
    for part in raw.split(";"):
        part = part.strip()
        if "=" in part:
            key, value = part.split("=", 1)
            cookies[key.strip()] = value.strip()
    return cookies


# ---------------------------------------------------------------------------
# Cookie sources
# ---------------------------------------------------------------------------

def _env_cookies():
    raw = os.environ.get("LEETCODE_COOKIE", "").strip()
    session = os.environ.get("LEETCODE_SESSION", "").strip()
    if not raw and session:
        raw = f"LEETCODE_SESSION={session}"
        csrf = os.environ.get("LEETCODE_CSRFTOKEN", "").strip()
        if csrf:
            raw += f"; csrftoken={csrf}"
    return parse_cookies(raw)


def _read_json(path):
    try:
        with open(path) as f:
            data = json.load(f)
    except (OSError, ValueError):
        return {}
    return data if isinstance(data, dict) else {}


def _cli_cookies():
    user = _read_json(os.path.expanduser(CLI_SESSION))
    cookies = parse_cookies(user.get("cookie", ""))
    if user.get("sessionId"):
        cookies.setdefault("LEETCODE_SESSION", user["sessionId"])
    if user.get("sessionCSRF"):
        cookies.setdefault("csrftoken", user["sessionCSRF"])
    return cookies


def _editor_cookies(path):
    try:
        con = sqlite3.connect(f"file:{path}?mode=ro", uri=True, timeout=2)
        try:
            row = con.execute(
                "select value from ItemTable "
                "where key = 'LeetCode.vscode-leetcode'"
            ).fetchone()
        finally:
            con.close()
        state = json.loads(row[0]) if row else {}
    except (sqlite3.Error, TypeError, ValueError):
        return {}
    cookie = state.get("leetcode-cookie") if isinstance(state, dict) else None
    return parse_cookies(cookie) if cookie else {}


_chrome_key = None


def _chrome_aes_key():
    """Derive Chrome's cookie AES key from the macOS Keychain (cached)."""
    global _chrome_key
    if _chrome_key is None:
        proc = subprocess.run(
            ["security", "find-generic-password", "-w",
             "-s", "Chrome Safe Storage"],
            capture_output=True, text=True,
        )
        if proc.returncode != 0:
            print("Note: Keychain access to 'Chrome Safe Storage' was denied; "
                  "skipping Chrome cookies.", file=sys.stderr)
            _chrome_key = b""
        else:
            _chrome_key = hashlib.pbkdf2_hmac(
                "sha1", proc.stdout.strip().encode(), b"saltysalt", 1003, 16)
    return _chrome_key


def _chrome_decrypt(encrypted, key, strip_hash):
    if encrypted[:3] != b"v10":
        return None
    proc = subprocess.run(
        ["openssl", "enc", "-d", "-aes-128-cbc",
         "-K", key.hex(), "-iv", "20" * 16],
        input=encrypted[3:], capture_output=True,
    )
    if proc.returncode != 0:
        return None
    plain = proc.stdout[32:] if strip_hash else proc.stdout
    return plain.decode(errors="replace")


def _chrome_profile_cookies(db_path):
    """Read leetcode.com cookies from one Chrome profile's Cookies DB."""
    now = int((time.time() + CHROME_EPOCH_OFFSET) * 1_000_000)
    # Copy first: Chrome keeps the DB locked and may have unflushed journals.
    with tempfile.TemporaryDirectory() as tmp:
        for suffix in ("", "-journal", "-wal"):
            if os.path.exists(db_path + suffix):
                shutil.copy(db_path + suffix,
                            os.path.join(tmp, "Cookies" + suffix))
        try:
            con = sqlite3.connect(os.path.join(tmp, "Cookies"))
            try:
                meta = con.execute(
                    "select value from meta where key = 'version'").fetchone()
                rows = con.execute(
                    "select name, value, encrypted_value from cookies "
                    "where host_key in ('leetcode.com', '.leetcode.com') "
                    "and name in (?, ?) "
                    "and (has_expires = 0 or expires_utc > ?) "
                    "order by expires_utc",
                    (*SESSION_KEYS, now),
                ).fetchall()
            finally:
                con.close()
        except sqlite3.Error:
            return {}

    if not any(name == "LEETCODE_SESSION" for name, _, _ in rows):
        return {}
    key = _chrome_aes_key()
    if not key:
        return {}
    # DB schema v24+ prefixes plaintext with SHA256(host_key)
    strip_hash = int(meta[0]) >= 24 if meta else False
    cookies = {}
    for name, value, encrypted in rows:  # later expiry wins
        value = value or _chrome_decrypt(encrypted, key, strip_hash)
        if value:
            cookies[name] = value
    return cookies


def cookie_sources():
    """Yield (label, cookies) candidates lazily, cheapest first."""
    yield "$LEETCODE_COOKIE", _env_cookies()
    yield CLI_SESSION, _cli_cookies()
    for db in STATE_DBS:
        path = os.path.expanduser(db)
        if os.path.exists(path):
            yield path.split("/")[-4] + " extension", _editor_cookies(path)
    chrome = os.path.expanduser(CHROME_DIR)
    profiles = [os.path.join(chrome, "Default")] + sorted(
        glob.glob(os.path.join(chrome, "Profile *")))
    for profile in profiles:
        db = os.path.join(profile, "Cookies")
        if os.path.exists(db):
            yield f"Chrome ({os.path.basename(profile)})", \
                _chrome_profile_cookies(db)


def load_cookies():
    """Return (cookies, username, source) for the first signed-in source.

    Sources whose session is expired are skipped. A session found outside the
    cache is written back to it, so the next run validates it first.
    Returns (None, None, None) when nothing is signed in.
    """
    seen = set()
    for label, cookies in cookie_sources():
        session = cookies.get("LEETCODE_SESSION")
        if not session or session in seen:
            continue
        seen.add(session)
        username = check_signed_in(cookies)
        if username:
            if label != CLI_SESSION:
                save_session(cookies, username)
            return cookies, username, label
    return None, None, None


# ---------------------------------------------------------------------------
# Session helpers
# ---------------------------------------------------------------------------

def fetch_csrf_token():
    """Obtain a csrftoken cookie; LeetCode sets one on any graphql request."""
    jar = http.cookiejar.CookieJar()
    opener = urllib.request.build_opener(
        urllib.request.HTTPCookieProcessor(jar),
        urllib.request.HTTPSHandler(context=ssl_context()),
    )
    req = urllib.request.Request(
        GRAPHQL_URL,
        headers={"User-Agent": USER_AGENT, "Referer": BASE_URL},
    )
    try:
        opener.open(req, timeout=15)
    except urllib.error.HTTPError:
        pass  # empty request answers 400, but still carries Set-Cookie
    except urllib.error.URLError as e:
        die(f"Cannot reach LeetCode: {e.reason}")
    except TimeoutError:
        die("LeetCode did not respond. Check your network/proxy and try again.")
    for cookie in jar:
        if cookie.name == "csrftoken":
            return cookie.value
    return ""


def auth_headers(cookies):
    return {
        "Cookie": "; ".join(f"{k}={v}" for k, v in cookies.items()),
        "X-CSRFToken": cookies.get("csrftoken", ""),
        "X-Requested-With": "XMLHttpRequest",
        "Origin": BASE_URL,
        "Referer": BASE_URL,
        "User-Agent": USER_AGENT,
    }


def check_signed_in(cookies):
    """Return the username if the session is valid, else None."""
    if not cookies.get("csrftoken"):
        cookies["csrftoken"] = fetch_csrf_token()
    user = (graphql_request(
        "query { userStatus { isSignedIn username } }",
        headers=auth_headers(cookies),
    ).get("data") or {}).get("userStatus") or {}
    return user.get("username") if user.get("isSignedIn") else None


def save_session(cookies, username):
    session = cookies["LEETCODE_SESSION"]
    path = os.path.expanduser(CLI_SESSION)
    data = _read_json(path)
    data.update({
        "cookie": f"LEETCODE_SESSION={session}",
        "sessionId": session,
        "sessionCSRF": cookies.get("csrftoken", ""),
        "login": username,
        "name": username,
    })
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        json.dump(data, f, indent=2)


NO_SESSION_HINT = (
    "  Log in to leetcode.com in Chrome (picked up automatically), or run:\n"
    "    ./lc cookie '<Cookie header from browser DevTools>'"
)


def show_status():
    _, username, source = load_cookies()
    if username:
        print(f"Signed in as {username} (from {source})")
    else:
        print("No valid LeetCode session found.")
        print(NO_SESSION_HINT)


def save_cookie(raw):
    cookies = parse_cookies(raw)
    if not cookies.get("LEETCODE_SESSION"):
        die("Cookie must include LEETCODE_SESSION.\n"
            "  Copy the full Cookie header from browser DevTools.")

    username = check_signed_in(cookies)
    if not username:
        die("Cookie rejected by LeetCode (expired or invalid).")

    save_session(cookies, username)
    print(f"Signed in as {username}. "
          f"Session saved to {os.path.expanduser(CLI_SESSION)}")


def main():
    if len(sys.argv) < 2:
        show_status()
    else:
        save_cookie(sys.argv[1])


if __name__ == "__main__":
    main()
