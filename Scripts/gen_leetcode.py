#!/usr/bin/env python3
"""
gen_leetcode.py - Generate a LeetCode Swift solution template.

Fetches problem metadata and Swift code snippet from LeetCode's GraphQL API,
creates a .swift file in the correct difficulty directory (Easy/Medium/Hard),
and adds it to the Tangram Xcode project in sorted order.

Usage:
    python3 Scripts/gen_leetcode.py <question_number>

Example:
    python3 Scripts/gen_leetcode.py 42
"""

import sys
import json
import os
import re
import ssl
import uuid
import urllib.request
import urllib.error

GRAPHQL_URL = "https://leetcode.com/graphql"

# macOS Python may lack system certificates; fall back to unverified context
try:
    _SSL_CTX = ssl.create_default_context()
    urllib.request.urlopen("https://leetcode.com", timeout=3, context=_SSL_CTX)
except Exception:
    _SSL_CTX = ssl._create_unverified_context()

PROJECT_ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LEETCODE_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "LeetCode")
PBXPROJ_PATH = os.path.join(
    PROJECT_ROOT, "Tangram", "Tangram.xcodeproj", "project.pbxproj"
)

# Xcode project IDs (from Tangram.xcodeproj/project.pbxproj)
GROUP_IDS = {
    "Easy": "0DBBE798306A9C4F005111DF",
    "Medium": "0DBBE8C0306A9C4F005111DF",
    "Hard": "0DBBE7AD306A9C4F005111DF",
}
SOURCES_PHASE_ID = "0D01F329281AE26D00794410"


# ---------------------------------------------------------------------------
# LeetCode API
# ---------------------------------------------------------------------------


def graphql_request(query, variables=None):
    """Send a GraphQL request to LeetCode."""
    payload = json.dumps({"query": query, "variables": variables or {}}).encode()
    req = urllib.request.Request(
        GRAPHQL_URL,
        data=payload,
        headers={
            "Content-Type": "application/json",
            "Referer": "https://leetcode.com",
            "User-Agent": "Mozilla/5.0",
        },
    )
    try:
        with urllib.request.urlopen(req, timeout=15, context=_SSL_CTX) as resp:
            return json.loads(resp.read().decode())
    except urllib.error.HTTPError as e:
        body = e.read().decode() if e.fp else ""
        print(f"Error: LeetCode API returned {e.code}: {body[:200]}")
        sys.exit(1)
    except urllib.error.URLError as e:
        print(f"Error: Cannot reach LeetCode API: {e.reason}")
        sys.exit(1)


def find_slug_by_id(qid):
    """Find the problem slug from its frontend question ID."""
    query = """
    query problemsetQuestionList(
        $categorySlug: String,
        $limit: Int,
        $skip: Int,
        $filters: QuestionListFilterInput
    ) {
        problemsetQuestionList: questionList(
            categorySlug: $categorySlug
            limit: $limit
            skip: $skip
            filters: $filters
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
    variables = {
        "categorySlug": "",
        "limit": 50,
        "skip": 0,
        "filters": {"searchKeywords": str(qid)},
    }
    data = graphql_request(query, variables)
    questions = (
        data.get("data", {})
        .get("problemsetQuestionList", {})
        .get("questions", [])
    )

    for q in questions:
        if str(q["frontendQuestionId"]) == str(qid):
            return q

    return None


def get_swift_snippet(slug):
    """Fetch the Swift code snippet for a problem by its slug."""
    query = """
    query questionEditorData($titleSlug: String!) {
        question(titleSlug: $titleSlug) {
            codeSnippets {
                lang
                langSlug
                code
            }
        }
    }
    """
    data = graphql_request(query, {"titleSlug": slug})
    snippets = (
        data.get("data", {}).get("question", {}).get("codeSnippets") or []
    )

    for s in snippets:
        if s["langSlug"] == "swift":
            return s["code"]

    return None


# ---------------------------------------------------------------------------
# Swift file generation
# ---------------------------------------------------------------------------


def generate_swift_content(problem, code):
    """Generate the Swift file content matching project conventions."""
    # Normalize line endings
    code = code.replace("\r\n", "\n")
    # Replace `class Solution` with `extension Solution` to avoid redeclaration
    code = code.replace("class Solution", "extension Solution")

    return (
        f"/*\n"
        f" * @lc app=leetcode id={problem['frontendQuestionId']} lang=swift\n"
        f" *\n"
        f" * [{problem['frontendQuestionId']}] {problem['title']}\n"
        f" */\n"
        f"\n"
        f"// @lc code=start\n"
        f"#if !LC_SOLUTION_EXT\n"
        f"class Solution {{}}\n"
        f"#endif\n"
        f"\n"
        f"{code}\n"
        f"// @lc code=end\n"
    )


# ---------------------------------------------------------------------------
# Xcode project manipulation
# ---------------------------------------------------------------------------


def _generate_pbx_id(existing_ids):
    """Generate a unique 24-character hex ID for pbxproj."""
    while True:
        new_id = uuid.uuid4().hex[:24].upper()
        if new_id not in existing_ids:
            return new_id


def _collect_existing_ids(content):
    """Extract all 24-char hex IDs already used in the pbxproj."""
    return set(re.findall(r'\b([0-9A-F]{24})\b', content))


def _problem_number(entry):
    """Extract the leading problem number from a pbxproj child entry."""
    m = re.search(r'/\*\s*(\d+)\.', entry)
    return int(m.group(1)) if m else 0


def add_to_xcode_project(filename, difficulty):
    """Add a Swift file to the Tangram Xcode project in sorted order.

    Modifies four sections of project.pbxproj:
      1. PBXBuildFile      - register the compile reference
      2. PBXFileReference  - register the file on disk
      3. PBXGroup          - insert into Easy/Medium/Hard, sorted by problem #
      4. PBXSourcesBuildPhase - add to the Tangram target's Sources phase
    """
    with open(PBXPROJ_PATH, "r") as f:
        content = f.read()

    if f"/* {filename} */" in content:
        print(f"  [pbxproj] {filename} already in project, skipping.")
        return

    ids = _collect_existing_ids(content)
    file_ref_id = _generate_pbx_id(ids)
    ids.add(file_ref_id)
    build_file_id = _generate_pbx_id(ids)

    # 1. PBXBuildFile
    content = content.replace(
        "/* End PBXBuildFile section */",
        f"\t\t{build_file_id} /* {filename} in Sources */ = "
        f"{{isa = PBXBuildFile; fileRef = {file_ref_id} "
        f"/* {filename} */; }};\n"
        f"/* End PBXBuildFile section */",
    )

    # 2. PBXFileReference
    content = content.replace(
        "/* End PBXFileReference section */",
        f'\t\t{file_ref_id} /* {filename} */ = '
        f'{{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; '
        f'path = "{filename}"; sourceTree = "<group>"; }};\n'
        f"/* End PBXFileReference section */",
    )

    # 3. PBXGroup - sorted insertion by problem number
    group_id = GROUP_IDS.get(difficulty)
    if not group_id:
        print(f"  [pbxproj] Warning: unknown difficulty '{difficulty}'.")
    else:
        group_marker = f"{group_id} /* {difficulty} */ = "
        group_pos = content.find(group_marker)
        if group_pos == -1:
            print(f"  [pbxproj] Warning: {difficulty} group not found.")
        else:
            children_open = content.find("children = (", group_pos)
            children_close = content.find("\n\t\t\t);", children_open)

            block = content[children_open + len("children = ("):children_close]
            entries = [ln.strip() for ln in block.split("\n") if ln.strip()]

            new_entry = f"{file_ref_id} /* {filename} */,"
            entries.append(new_entry)
            entries.sort(key=_problem_number)

            rebuilt = "\n".join(f"\t\t\t\t{e}" for e in entries)
            content = (
                content[:children_open + len("children = (")]
                + f"\n{rebuilt}\n"
                + content[children_close + 1:]
            )

    # 4. PBXSourcesBuildPhase
    src_pos = content.find(f"{SOURCES_PHASE_ID} /* Sources */ = ")
    if src_pos == -1:
        print("  [pbxproj] Warning: Sources build phase not found.")
    else:
        files_open = content.find("files = (", src_pos)
        files_close = content.find("\n\t\t\t);", files_open)
        content = (
            content[:files_close]
            + f"\n\t\t\t\t{build_file_id} /* {filename} in Sources */,"
            + content[files_close:]
        )

    with open(PBXPROJ_PATH, "w") as f:
        f.write(content)

    print(f"  [pbxproj] Added to {difficulty} group (sorted by problem #)")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------


def _parse_ids(argv):
    """Parse questions IDs from args: './lc 1 2 3' or './lc 1,2,3' or mixed."""
    ids = []
    for arg in argv:
        for part in arg.split(","):
            part = part.strip()
            if part.isdigit():
                ids.append(part)
    return ids


def generate_one(qid):
    """Fetch, generate, and register one problem. Return True on success."""
    print(f"\nFetching question #{qid} from LeetCode...")

    problem = find_slug_by_id(qid)
    if not problem:
        print(f"  Error: Question #{qid} not found.")
        return False

    code = get_swift_snippet(problem["titleSlug"])
    if code is None:
        print(f"  Error: No Swift code snippet for [{qid}] {problem['title']}.")
        return False

    difficulty = problem["difficulty"]  # Easy / Medium / Hard
    target_dir = os.path.join(LEETCODE_DIR, difficulty)
    filename = f"{problem['frontendQuestionId']}.{problem['titleSlug']}.swift"
    filepath = os.path.join(target_dir, filename)

    if os.path.exists(filepath):
        print(f"  {filename} already exists, skipping.")
        add_to_xcode_project(filename, difficulty)
        return True

    os.makedirs(target_dir, exist_ok=True)
    content = generate_swift_content(problem, code)

    with open(filepath, "w") as f:
        f.write(content)

    print(f"  [{problem['frontendQuestionId']}] {problem['title']} ({difficulty})")
    print(f"  -> {os.path.relpath(filepath, PROJECT_ROOT)}")

    add_to_xcode_project(filename, difficulty)
    return True


def main():
    ids = sorted(_parse_ids(sys.argv[1:]), key=int)
    if not ids:
        print("Usage: ./lc <id> [id ...]\n  e.g. ./lc 1 2 3  or  ./lc 1,2,3")
        sys.exit(1)

    ok, fail = 0, 0
    for qid in ids:
        if generate_one(qid):
            ok += 1
        else:
            fail += 1

    if len(ids) > 1:
        print(f"\nDone: {ok} added, {fail} failed.")


if __name__ == "__main__":
    main()
