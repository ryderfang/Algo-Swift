"""Shared LeetCode API and Xcode project utilities for gen_*.py scripts."""

import json
import os
import re
import ssl
import sys
import uuid
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


# ---------------------------------------------------------------------------
# Xcode project (pbxproj) helpers
# ---------------------------------------------------------------------------

PBXPROJ_PATH = os.path.join(
    PROJECT_ROOT, "Tangram", "Tangram.xcodeproj", "project.pbxproj"
)

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
