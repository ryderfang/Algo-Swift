#!/usr/bin/env python3
"""
submit_leetcode.py - Submit a generated solution to LeetCode.

Extracts the code between the `@lc code=start` and `@lc code=end` markers,
posts it to the judge, and polls for the result.

Submission requires a logged-in session (LeetCode's public GraphQL exposes
no submit mutation; the REST judge endpoints used by the website and the
VS Code extension are the only option). The session is discovered
automatically (env, ~/.lc cache, editor extension, Chrome); see
lc_cookie.load_cookies.

Usage:  ./lc submit <question_number>     e.g. ./lc submit 1005
"""

import glob
import json
import os
import re
import sys
import time

from lc_common import (BASE_URL, PROJECT_ROOT, die, graphql_request,
                       request_json)
from lc_cookie import NO_SESSION_HINT, auth_headers, load_cookies

LEETCODE_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "LeetCode")
POLL_INTERVAL = 1.5
POLL_TIMEOUT = 120


# ---------------------------------------------------------------------------
# Local solution file
# ---------------------------------------------------------------------------

def find_solution_file(qid):
    """Locate <difficulty>/<id>.<slug>.swift in the LeetCode workspace."""
    matches = sorted(glob.glob(os.path.join(LEETCODE_DIR, "*", f"{qid}.*.swift")))
    if not matches:
        die(f"Solution file for #{qid} not found. Run ./lc {qid} first.")
    return matches[0]


def extract_code(path):
    """Extract the code to submit from the @lc markers.

    The project compiles solutions as `extension Solution` behind an
    LC_SOLUTION_EXT guard; LeetCode expects a plain `class Solution`.
    """
    with open(path, "r") as f:
        content = f.read()

    match = re.search(r"//\s*@lc code=start\s*\n(.*?)//\s*@lc code=end",
                      content, re.S)
    if not match:
        die(f"No '@lc code=start' / '@lc code=end' markers in {path}")

    code = match.group(1)
    code = re.sub(
        r"#if !LC_SOLUTION_EXT\s*\nclass Solution \{\}\s*\n#endif\s*\n?",
        "", code,
    )
    code = re.sub(r"\bextension Solution\b", "class Solution", code, count=1)
    return code.strip() + "\n"


# ---------------------------------------------------------------------------
# Judge API
# ---------------------------------------------------------------------------

def fetch_question(slug, headers):
    """Title, difficulty and the internal question id (e.g. frontend
    1005 -> 1047) required by submit."""
    data = graphql_request(
        "query($slug: String!) { question(titleSlug: $slug) "
        "{ questionId title difficulty } }",
        {"slug": slug}, headers=headers,
    ).get("data") or {}
    question = data.get("question") or {}
    if not question.get("questionId"):
        die(f"Could not fetch the LeetCode question id for '{slug}'.")
    return question


def submit(slug, question_id, code, headers):
    payload = {
        "lang": "swift",
        "question_id": question_id,
        "typed_code": code,
        "test_mode": False,
        "judge_type": "large",
    }
    h = dict(headers)
    h["Referer"] = f"{BASE_URL}/problems/{slug}/"
    data = request_json(f"{BASE_URL}/problems/{slug}/submit/",
                        json.dumps(payload).encode(), h)
    submission_id = data.get("submission_id")
    if not submission_id:
        die(f"Submission rejected: "
            f"{data.get('error') or json.dumps(data)[:300]}")
    return submission_id


def wait_for_result(submission_id, slug, headers):
    h = dict(headers)
    h["Referer"] = f"{BASE_URL}/problems/{slug}/"
    url = f"{BASE_URL}/submissions/detail/{submission_id}/check/"
    deadline = time.time() + POLL_TIMEOUT
    while time.time() < deadline:
        data = request_json(url, headers=h)
        if data.get("state") == "SUCCESS":
            return data
        time.sleep(POLL_INTERVAL)
    die(f"Timed out waiting for submission #{submission_id}.")


def print_result(result):
    status = result.get("status_msg") or "Unknown"
    total = result.get("total_testcases") or 0
    passed = result.get("total_correct") or 0

    print(f"\n  {status}")
    if total:
        print(f"  Tests: {passed}/{total}")

    for label, value_key, pct_key in (
        ("Runtime", "status_runtime", "runtime_percentile"),
        ("Memory", "status_memory", "memory_percentile"),
    ):
        if result.get(value_key):
            pct = result.get(pct_key)
            suffix = (f" (beats {pct:.1f}%)"
                      if isinstance(pct, (int, float)) else "")
            print(f"  {label}: {result[value_key]}{suffix}")

    for key in ("full_compile_error", "compile_error",
                "full_runtime_error", "runtime_error"):
        if result.get(key):
            print(f"  {key.replace('_', ' ').capitalize()}:")
            print("    " + str(result[key]).replace("\n", "\n    "))
            break

    if status != "Accepted":
        for label, key in (("Last testcase", "last_testcase"),
                           ("Expected", "expected_output"),
                           ("Output", "code_output")):
            if result.get(key):
                print(f"  {label}: {result[key]}")

    return status == "Accepted"


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    if len(sys.argv) != 2 or not sys.argv[1].isdigit():
        print("Usage: ./lc submit <question_number>")
        sys.exit(1)

    qid = sys.argv[1]
    path = find_solution_file(qid)
    slug = os.path.basename(path).split(".")[1]
    code = extract_code(path)

    cookies, username, source = load_cookies()
    if not cookies:
        die("No valid LeetCode session found.\n" + NO_SESSION_HINT)
    headers = auth_headers(cookies)

    problem = fetch_question(slug, headers)
    question_id = int(problem["questionId"])

    print(f"[{qid}] {problem['title']} ({problem['difficulty']})")
    print(f"  user: {username} (from {source})")
    print(f"  file: {os.path.relpath(path, PROJECT_ROOT)}")
    print(f"  code: {len(code.splitlines())} lines")

    submission_id = submit(slug, question_id, code, headers)
    print(f"  submission #{submission_id} sent, waiting for judge...")

    accepted = print_result(wait_for_result(submission_id, slug, headers))
    sys.exit(0 if accepted else 1)


if __name__ == "__main__":
    main()
