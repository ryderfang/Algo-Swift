#!/usr/bin/env python3
"""
lc_cookie.py - Manage the LeetCode session used by `./lc submit`.

Usage:
  ./lc cookie              Show current sign-in status
  ./lc cookie '<cookie>'   Save a cookie from browser DevTools and verify it
"""

import http.cookiejar
import json
import os
import sqlite3
import sys
import urllib.error
import urllib.request

from lc_common import (BASE_URL, GRAPHQL_URL, USER_AGENT, die,
                       graphql_request, ssl_context)

# Session cache written by vsc-leetcode-cli (used by the VS Code extension)
CLI_SESSION = "~/.lc/leetcode/user.json"

# Editor global-state databases that may hold the LeetCode extension cookie
STATE_DBS = [
    "~/Library/Application Support/Code/User/globalStorage/state.vscdb",
    "~/Library/Application Support/Cursor/User/globalStorage/state.vscdb",
]


def parse_cookies(raw):
    cookies = {}
    for part in raw.split(";"):
        part = part.strip()
        if "=" in part:
            key, value = part.split("=", 1)
            cookies[key.strip()] = value.strip()
    return cookies


def load_cookies():
    """Collect LEETCODE_SESSION / csrftoken from env, the leetcode-cli
    session cache, or the editor's LeetCode extension state."""
    raw = os.environ.get("LEETCODE_COOKIE", "").strip()
    if not raw:
        session = os.environ.get("LEETCODE_SESSION", "").strip()
        if session:
            raw = f"LEETCODE_SESSION={session}"
            csrf = os.environ.get("LEETCODE_CSRFTOKEN", "").strip()
            if csrf:
                raw += f"; csrftoken={csrf}"
    if raw:
        return parse_cookies(raw)

    cli_session = os.path.expanduser(CLI_SESSION)
    if os.path.exists(cli_session):
        try:
            with open(cli_session) as f:
                user = json.load(f)
        except (OSError, ValueError):
            user = {}
        cookies = parse_cookies(user.get("cookie", ""))
        if user.get("sessionId"):
            cookies.setdefault("LEETCODE_SESSION", user["sessionId"])
        if user.get("sessionCSRF"):
            cookies.setdefault("csrftoken", user["sessionCSRF"])
        if cookies:
            return cookies

    for db in STATE_DBS:
        path = os.path.expanduser(db)
        if not os.path.exists(path):
            continue
        try:
            con = sqlite3.connect(f"file:{path}?mode=ro", uri=True, timeout=2)
            try:
                row = con.execute(
                    "select value from ItemTable "
                    "where key = 'LeetCode.vscode-leetcode'"
                ).fetchone()
            finally:
                con.close()
        except sqlite3.Error:
            continue
        if not row:
            continue
        try:
            state = json.loads(row[0])
        except (TypeError, ValueError):
            continue
        cookie = state.get("leetcode-cookie")
        if cookie:
            return parse_cookies(cookie)
    return {}


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


def show_status():
    cookies = load_cookies()
    if not cookies.get("LEETCODE_SESSION"):
        print("No LeetCode session found.")
        print("  Save one with: ./lc cookie '<cookie from browser>'")
        return
    username = check_signed_in(cookies)
    if username:
        print(f"Signed in as {username}")
    else:
        print("Session expired or invalid.")
        print("  Get a fresh cookie from leetcode.com "
              "(DevTools > Network > any request > Cookie header),")
        print("  then run: ./lc cookie '<cookie>'")


def save_cookie(raw):
    cookies = parse_cookies(raw)
    if not cookies.get("LEETCODE_SESSION"):
        die("Cookie must include LEETCODE_SESSION.\n"
            "  Copy the full Cookie header from browser DevTools.")

    username = check_signed_in(cookies)
    if not username:
        die("Cookie rejected by LeetCode (expired or invalid).")

    session = cookies["LEETCODE_SESSION"]
    path = os.path.expanduser(CLI_SESSION)
    data = {}
    if os.path.exists(path):
        try:
            with open(path) as f:
                data = json.load(f)
        except (OSError, ValueError):
            data = {}
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
    print(f"Signed in as {username}. Session saved to {path}")


def main():
    if len(sys.argv) < 2:
        show_status()
    else:
        save_cookie(sys.argv[1])


if __name__ == "__main__":
    main()
