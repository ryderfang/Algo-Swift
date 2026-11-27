#!/usr/bin/env python3
"""
gen_leetcode.py - Generate a LeetCode Swift solution template.

Fetches problem metadata and Swift code snippet from LeetCode's GraphQL API,
creates a .swift file in the correct difficulty directory (Easy/Medium/Hard),
and adds it to the Tangram Xcode project in sorted order. Test cases are set up
from the same fetch (see gen_tests.py), so each problem is fetched only once.

Usage:  python3 Scripts/gen_leetcode.py <question_number> [...]
"""

import os
import re
import sys

from lc_common import (PROJECT_ROOT, PBXPROJ_PATH, parse_ids,
                       swift_snippet, generate_pbx_id, DIFFICULTY_GROUP_IDS)
from gen_tests import run

LEETCODE_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "LeetCode")

GROUP_IDS = DIFFICULTY_GROUP_IDS["LeetCode"]
SOURCES_PHASE_ID = "0D01F329281AE26D00794410"


# ---------------------------------------------------------------------------
# Swift file generation
# ---------------------------------------------------------------------------

def generate_swift_content(problem, code):
    """Generate the Swift file content matching project conventions."""
    code = code.replace("\r\n", "\n").replace("class Solution", "extension Solution")
    qid, title = problem["frontendQuestionId"], problem["title"]
    return (
        f"/*\n * @lc app=leetcode id={qid} lang=swift\n *\n"
        f" * [{qid}] {title}\n */\n\n"
        f"// @lc code=start\n#if !LC_SOLUTION_EXT\nclass Solution {{}}\n#endif\n\n"
        f"{code}\n// @lc code=end\n"
    )


# ---------------------------------------------------------------------------
# Xcode project manipulation
# ---------------------------------------------------------------------------

def _problem_number(entry):
    m = re.search(r'/\*\s*(\d+)\.', entry)
    return int(m.group(1)) if m else 0


def add_to_xcode_project(filename, difficulty):
    """Add a Swift file to the Tangram Xcode project in sorted order."""
    with open(PBXPROJ_PATH, "r") as f:
        content = f.read()

    if f"/* {filename} */" in content:
        print(f"  [pbxproj] {filename} already in project, skipping.")
        return

    file_ref_id = generate_pbx_id(content)
    build_file_id = generate_pbx_id(content + file_ref_id)

    # PBXBuildFile
    content = content.replace(
        "/* End PBXBuildFile section */",
        f"\t\t{build_file_id} /* {filename} in Sources */ = "
        f"{{isa = PBXBuildFile; fileRef = {file_ref_id} "
        f"/* {filename} */; }};\n/* End PBXBuildFile section */",
    )
    # PBXFileReference
    content = content.replace(
        "/* End PBXFileReference section */",
        f'\t\t{file_ref_id} /* {filename} */ = '
        f'{{isa = PBXFileReference; lastKnownFileType = sourcecode.swift; '
        f'path = "{filename}"; sourceTree = "<group>"; }};\n'
        f"/* End PBXFileReference section */",
    )
    # PBXGroup - sorted insertion
    group_id = GROUP_IDS.get(difficulty)
    if group_id:
        marker = f"{group_id} /* {difficulty} */ = "
        pos = content.find(marker)
        if pos != -1:
            co = content.find("children = (", pos)
            cc = content.find("\n\t\t\t);", co)
            block = content[co + len("children = ("):cc]
            entries = [ln.strip() for ln in block.split("\n") if ln.strip()]
            entries.append(f"{file_ref_id} /* {filename} */,")
            entries.sort(key=_problem_number)
            rebuilt = "\n".join(f"\t\t\t\t{e}" for e in entries)
            content = content[:co + len("children = (")] + f"\n{rebuilt}\n" + content[cc + 1:]

    # PBXSourcesBuildPhase
    sp = content.find(f"{SOURCES_PHASE_ID} /* Sources */ = ")
    if sp != -1:
        fo = content.find("files = (", sp)
        fc = content.find("\n\t\t\t);", fo)
        content = (content[:fc]
                   + f"\n\t\t\t\t{build_file_id} /* {filename} in Sources */,"
                   + content[fc:])

    with open(PBXPROJ_PATH, "w") as f:
        f.write(content)
    print(f"  [pbxproj] Added to {difficulty} group (sorted by problem #)")


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def generate_solution(problem):
    """Generate and register the solution file for a fetched problem. Return True on success."""
    code = swift_snippet(problem)
    if code is None:
        print(f"  Error: No Swift code snippet for [{problem['frontendQuestionId']}] {problem['title']}.")
        return False

    difficulty = problem["difficulty"]
    target_dir = os.path.join(LEETCODE_DIR, difficulty)
    filename = f"{problem['frontendQuestionId']}.{problem['titleSlug']}.swift"
    filepath = os.path.join(target_dir, filename)

    if os.path.exists(filepath):
        print(f"  {filename} already exists, skipping.")
    else:
        os.makedirs(target_dir, exist_ok=True)
        with open(filepath, "w") as f:
            f.write(generate_swift_content(problem, code))
        print(f"  -> {os.path.relpath(filepath, PROJECT_ROOT)}")
    add_to_xcode_project(filename, difficulty)
    return True


def main():
    run(parse_ids(sys.argv[1:]), before=generate_solution,
        usage="./lc <id> [id ...]\n  e.g. ./lc 1 2 3  or  ./lc 1,2,3")


if __name__ == "__main__":
    main()
