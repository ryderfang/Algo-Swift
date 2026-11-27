"""Shared LeetCode API and Xcode project utilities for gen_*.py scripts."""

import json
import os
import re
import ssl
import sys
import time
import uuid
import urllib.request
import urllib.error

BASE_URL = "https://leetcode.com"
GRAPHQL_URL = f"{BASE_URL}/graphql"
USER_AGENT = ("Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) "
              "AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0 Safari/537.36")
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

_ssl_ctx = None

def _get_ssl_ctx():
    global _ssl_ctx
    if _ssl_ctx is None:
        _ssl_ctx = ssl.create_default_context()
        # Corporate proxy CAs often lack the key-usage extension that strict
        # mode (default since Python 3.13) requires; keep verification on.
        _ssl_ctx.verify_flags &= ~ssl.VERIFY_X509_STRICT
        if not _ssl_ctx.cert_store_stats().get("x509_ca"):
            _ssl_ctx = ssl._create_unverified_context()
    return _ssl_ctx


RETRIES = 3


def _read(req, timeout, retries=RETRIES):
    """urlopen + read, retrying requests that time out.

    The corporate proxy (Zscaler) sometimes accepts the connection and then
    never answers; a fresh request usually goes through.
    """
    for attempt in range(1, retries + 1):
        try:
            with urllib.request.urlopen(req, timeout=timeout,
                                        context=_get_ssl_ctx()) as resp:
                return resp.read().decode()
        except urllib.error.HTTPError:
            raise
        except urllib.error.URLError as e:
            if not isinstance(e.reason, TimeoutError):
                raise
        except TimeoutError:
            pass
        if attempt < retries:
            print(f"  LeetCode timed out, retrying ({attempt + 1}/{retries})...",
                  file=sys.stderr)
            time.sleep(attempt)
    tries = f" after {retries} tries" if retries > 1 else ""
    die(f"LeetCode did not respond within {timeout}s{tries}. "
        "Check your network/proxy and try again.")


def graphql_request(query, variables=None, headers=None):
    """Send a GraphQL request to LeetCode."""
    payload = json.dumps({"query": query, "variables": variables or {}}).encode()
    req_headers = {"Content-Type": "application/json",
                   "Referer": "https://leetcode.com",
                   "User-Agent": "Mozilla/5.0"}
    if headers:
        req_headers.update(headers)
    req = urllib.request.Request(GRAPHQL_URL, data=payload, headers=req_headers)
    try:
        return json.loads(_read(req, timeout=15))
    except urllib.error.HTTPError as e:
        body = e.read().decode() if e.fp else ""
        print(f"Error: LeetCode API returned {e.code}: {body[:200]}")
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Error: Cannot reach LeetCode API: {e.reason}")
        sys.exit(1)


def ssl_context():
    """Shared SSL context (falls back to unverified if certs are unavailable)."""
    return _get_ssl_ctx()


def die(message):
    print(f"Error: {message}", file=sys.stderr)
    sys.exit(1)


def request_json(url, data=None, headers=None, timeout=20):
    """JSON-over-HTTP request with LeetCode-flavored error handling."""
    req = urllib.request.Request(url, data=data, headers=headers or {})
    try:
        # Only retry GETs: retrying a POST (e.g. submit) could submit twice.
        body = _read(req, timeout, retries=RETRIES if data is None else 1)
    except urllib.error.HTTPError as e:
        if e.code in (401, 403):
            die("LeetCode refused the request (session expired or invalid).\n"
                "  Log in to leetcode.com in Chrome, or run: ./lc cookie '<cookie>'")
        body = e.read().decode(errors="replace")[:300] if e.fp else ""
        die(f"LeetCode API returned HTTP {e.code}: {body}")
    except urllib.error.URLError as e:
        die(f"Cannot reach LeetCode: {e.reason}")
    try:
        return json.loads(body)
    except ValueError:
        die(f"Unexpected response from LeetCode: {body[:200]}")


def parse_ids(argv):
    """Parse question IDs from args like ["1", "2,3"] -> ["1", "2", "3"]."""
    return [part.strip() for arg in argv for part in arg.split(",")
            if part.strip().isdigit()]


def find_problem(qid):
    """Find a problem by frontend question ID. Returns dict or None."""
    query = """
    query problemsetQuestionList(
        $categorySlug: String, $limit: Int, $skip: Int,
        $filters: QuestionListFilterInput
    ) {
        problemsetQuestionList: questionList(
            categorySlug: $categorySlug, limit: $limit,
            skip: $skip, filters: $filters
        ) {
            questions: data {
                frontendQuestionId: questionFrontendId
                titleSlug
                title
                difficulty
            }
        }
    }
    """
    data = graphql_request(query, {
        "categorySlug": "", "limit": 50, "skip": 0,
        "filters": {"searchKeywords": str(qid)},
    })
    for q in (data.get("data", {})
              .get("problemsetQuestionList", {})
              .get("questions", [])):
        if str(q["frontendQuestionId"]) == str(qid):
            return q
    return None


def fetch_problem(qid):
    """Fetch full problem data: metadata, test cases, content, code snippets."""
    problem = find_problem(qid)
    if not problem:
        return None
    detail = graphql_request("""
    query questionData($titleSlug: String!) {
        question(titleSlug: $titleSlug) {
            metaData
            exampleTestcaseList
            content
            codeSnippets { langSlug, code }
        }
    }
    """, {"titleSlug": problem["titleSlug"]})
    q = detail.get("data", {}).get("question", {})
    problem["metaData"] = json.loads(q.get("metaData", "{}"))
    problem["exampleTestcaseList"] = q.get("exampleTestcaseList", [])
    problem["content"] = q.get("content", "")
    problem["codeSnippets"] = q.get("codeSnippets") or []
    return problem


def swift_snippet(problem):
    """Extract Swift code snippet from a fetched problem."""
    for s in problem.get("codeSnippets", []):
        if s["langSlug"] == "swift":
            return s["code"]
    return None


# ---------------------------------------------------------------------------
# Xcode project (pbxproj) helpers
# ---------------------------------------------------------------------------

PBXPROJ_PATH = os.path.join(
    PROJECT_ROOT, "Tangram", "Tangram.xcodeproj", "project.pbxproj"
)

# Xcode PBXGroup IDs for difficulty subgroups
DIFFICULTY_GROUP_IDS = {
    "LeetCode": {
        "Easy": "0DBBE798306A9C4F005111DF",
        "Medium": "0DBBE8C0306A9C4F005111DF",
        "Hard": "0DBBE7AD306A9C4F005111DF",
    },
    "TestCases": {
        "Easy": "0D7360E53082215F00DFD004",
        "Medium": "0D7360E63082216800DFD004",
        "Hard": "0D7360E73082216D00DFD004",
    },
}


def generate_pbx_id(content):
    """Generate a unique 24-char hex ID not already in the pbxproj content."""
    existing = set(re.findall(r'\b([0-9A-F]{24})\b', content))
    while True:
        new_id = uuid.uuid4().hex[:24].upper()
        if new_id not in existing:
            return new_id


def add_file_to_group(filename, group_id, file_type="text.json"):
    """Add a file reference to a PBXGroup in the Xcode project.

    Only adds PBXFileReference + group child (no PBXBuildFile — for data files).
    Skips if the file is already in the project.
    """
    with open(PBXPROJ_PATH, "r") as f:
        content = f.read()

    if f"/* {filename} */" in content:
        return  # already there

    file_ref_id = generate_pbx_id(content)

    # PBXFileReference
    content = content.replace(
        "/* End PBXFileReference section */",
        f'\t\t{file_ref_id} /* {filename} */ = '
        f'{{isa = PBXFileReference; lastKnownFileType = {file_type}; '
        f'path = "{filename}"; sourceTree = "<group>"; }};\n'
        f"/* End PBXFileReference section */",
    )

    # PBXGroup — sorted insertion
    marker = f"{group_id} /* "
    pos = content.find(marker)
    if pos != -1:
        co = content.find("children = (", pos)
        cc = content.find("\n\t\t\t);", co)
        block = content[co + len("children = ("):cc]
        entries = [ln.strip() for ln in block.split("\n") if ln.strip()]
        entries.append(f"{file_ref_id} /* {filename} */,")
        # Sort by leading number in filename (e.g. "1614.json")
        def sort_key(e):
            m = re.search(r'/\*\s*(\d+)', e)
            return int(m.group(1)) if m else 0
        entries.sort(key=sort_key)
        rebuilt = "\n".join(f"\t\t\t\t{e}" for e in entries)
        content = content[:co + len("children = (")] + f"\n{rebuilt}\n" + content[cc + 1:]

    with open(PBXPROJ_PATH, "w") as f:
        f.write(content)
