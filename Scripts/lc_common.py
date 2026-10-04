"""Shared LeetCode API utilities for gen_*.py scripts."""

import json
import os
import ssl
import sys
import urllib.request
import urllib.error

GRAPHQL_URL = "https://leetcode.com/graphql"
PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

_ssl_ctx = None

def _get_ssl_ctx():
    global _ssl_ctx
    if _ssl_ctx is None:
        try:
            _ssl_ctx = ssl.create_default_context()
            urllib.request.urlopen("https://leetcode.com", timeout=3, context=_ssl_ctx)
        except Exception:
            _ssl_ctx = ssl._create_unverified_context()
    return _ssl_ctx


def graphql_request(query, variables=None):
    """Send a GraphQL request to LeetCode."""
    payload = json.dumps({"query": query, "variables": variables or {}}).encode()
    req = urllib.request.Request(
        GRAPHQL_URL, data=payload,
        headers={"Content-Type": "application/json",
                 "Referer": "https://leetcode.com",
                 "User-Agent": "Mozilla/5.0"},
    )
    try:
        with urllib.request.urlopen(req, timeout=15, context=_get_ssl_ctx()) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        body = e.read().decode() if e.fp else ""
        print(f"Error: LeetCode API returned {e.code}: {body[:200]}")
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Error: Cannot reach LeetCode API: {e.reason}")
        sys.exit(1)


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
