#!/usr/bin/env python3
"""
gen_tests.py - Generate test cases for a LeetCode problem.

Fetches example test cases from LeetCode, saves them as plain-text, and
generates ProblemDispatch.swift with only the current problem's dispatch entry.

Usage:  python3 Scripts/gen_tests.py <question_number>
"""

import json
import os
import re
import sys

from lc_common import PROJECT_ROOT, fetch_problem, add_file_to_group

RUNNER_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "Runner")
TESTCASES_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "TestCases")
DISPATCH_PATH = os.path.join(RUNNER_DIR, "ProblemDispatch.swift")
RUNNER_PATH = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "Runner.swift")

# Xcode TestCases group ID (from project.pbxproj)
TESTCASES_GROUP_ID = "0D9C216D3072485A00EDE4B9"

# ---------------------------------------------------------------------------
# Type mapping: LeetCode types -> Swift TestCase parser expressions
# ---------------------------------------------------------------------------

INPUT_PARSERS = {
    "integer": "tc.int({i})", "long": "tc.int({i})",
    "double": "tc.double({i})", "float": "tc.double({i})",
    "boolean": "tc.bool({i})", "string": "tc.string({i})",
    "character": "tc.char({i})",
    "integer[]": "tc.intArray({i})", "long[]": "tc.intArray({i})",
    "integer[][]": "tc.intArray2D({i})",
    "string[]": "tc.stringArray({i})", "string[][]": "tc.stringArray2D({i})",
    "boolean[]": "tc.boolArray({i})", "double[]": "tc.doubleArray({i})",
    "character[]": "tc.charArray({i})", "character[][]": "tc.charArray2D({i})",
    "TreeNode": "tc.treeNode({i})", "ListNode": "tc.listNode({i})",
    "list<integer>": "tc.intArray({i})", "list<string>": "tc.stringArray({i})",
    "list<list<integer>>": "tc.intArray2D({i})",
    "list<list<string>>": "tc.stringArray2D({i})",
}

# return type -> (expected expr, assertion style)
EXPECTED_MAP = {
    "integer": ("tc.expectedInt", "equal"), "long": ("tc.expectedInt", "equal"),
    "double": ("tc.expectedDouble", "accuracy"), "float": ("tc.expectedDouble", "accuracy"),
    "boolean": ("tc.expectedBool", "equal"),
    "string": ("tc.expectedString", "equal"), "character": ("tc.expectedChar", "equal"),
    "integer[]": ("tc.expectedIntArray", "equal"), "long[]": ("tc.expectedIntArray", "equal"),
    "integer[][]": ("tc.expectedIntArray2D", "equal"),
    "string[]": ("tc.expectedStringArray", "equal"),
    "string[][]": ("tc.expectedStringArray2D", "equal"),
    "boolean[]": ("tc.expectedBoolArray", "equal"),
    "double[]": ("tc.expectedDoubleArray", "equal"),
    "character[]": ("tc.expectedCharArray", "equal"),
    "TreeNode": ("tc.expectedOptionalIntArray", "tree"),
    "ListNode": ("tc.expectedIntArray", "list"),
    "list<integer>": ("tc.expectedIntArray", "equal"),
    "list<string>": ("tc.expectedStringArray", "equal"),
    "list<list<integer>>": ("tc.expectedIntArray2D", "equal"),
    "list<list<string>>": ("tc.expectedStringArray2D", "equal"),
    "void": (None, "void"),
}


# ---------------------------------------------------------------------------
# HTML parsing & dispatch code generation
# ---------------------------------------------------------------------------

def parse_outputs_from_html(content):
    """Extract expected output values from the problem HTML."""
    outputs = []
    for m in re.finditer(
        r'<strong>Output:</strong>\s*(?:<span[^>]*>)?(.+?)(?:</span>|<strong>|\n|</pre>|</p>)',
        content,
    ):
        val = m.group(1).strip()
        for old, new in [("&quot;", '"'), ("&amp;", "&"), ("&lt;", "<"), ("&gt;", ">")]:
            val = val.replace(old, new)
        outputs.append(val)
    return outputs


def generate_dispatch_body(func_name, params, return_type):
    """Generate the assertion body inside a for-loop over test cases."""
    args = ", ".join(
        INPUT_PARSERS.get(p["type"], "tc.string({i})").format(i=i)
        for i, p in enumerate(params)
    )
    call = f"sol.{func_name}({args})"
    expected_expr, style = EXPECTED_MAP.get(return_type, ("tc.expectedString", "equal"))

    if style == "void":
        return f"            // void return - verify side effects manually\n            {call}"
    elif style in ("tree", "list"):
        return (f"            let result = {call}\n"
                f"            check(result?.array() ?? [], {expected_expr}, "
                f"\"Case \\(i + 1)\", &passed, &failed)")
    elif style == "accuracy":
        return (f"            checkAccuracy({call}, {expected_expr}, "
                f"accuracy: 1e-5, \"Case \\(i + 1)\", &passed, &failed)")
    else:
        return (f"            check({call}, {expected_expr}, "
                f"\"Case \\(i + 1)\", &passed, &failed)")


# ---------------------------------------------------------------------------
# File generation
# ---------------------------------------------------------------------------

DISPATCH_TEMPLATE = """\
//
//  ProblemDispatch.swift
//  Tangram
//
//  Auto-generated by gen_tests.py. Do not edit manually.
//

enum ProblemRunner {{
    static func run(_ id: Int) {{
        let sol = Solution()
        let cases = loadTestCases(id)
        guard !cases.isEmpty else {{
            print("No test cases for problem #\\(id). Run: python3 Scripts/gen_tests.py \\(id)")
            return
        }}

        print("--- [\\(id)] {title} ---")
        var passed = 0, failed = 0

        for (i, tc) in cases.enumerated() {{
{body}
        }}

        print("\\(passed + failed) tests: \\(passed) passed, \\(failed) failed")
    }}

    private static func check<T: Equatable>(_ got: T, _ expected: T, _ label: String, _ passed: inout Int, _ failed: inout Int) {{
        if got == expected {{
            passed += 1
            print("  \\(label) pass")
        }} else {{
            failed += 1
            print("  \\(label) FAIL  got: \\(got), expected: \\(expected)")
        }}
    }}

    private static func checkAccuracy(_ got: Double, _ expected: Double, accuracy: Double, _ label: String, _ passed: inout Int, _ failed: inout Int) {{
        if abs(got - expected) <= accuracy {{
            passed += 1
            print("  \\(label) pass")
        }} else {{
            failed += 1
            print("  \\(label) FAIL  got: \\(got), expected: \\(expected)")
        }}
    }}
}}
"""


def write_txt_testcases(qid, problem):
    """Write test case data to TestCases/<id>.txt in plain-text format.

    Format:
        id: 167
        title: Two Sum II
        ...
        ---
        [2,7,11,15]
        9
        = [1,2]

        [2,3,4]
        6
        = [1,3]
    """
    meta = problem["metaData"]
    inputs_list = problem["exampleTestcaseList"]
    outputs = parse_outputs_from_html(problem["content"])

    params_str = ", ".join(
        f"{p['name']}:{p['type']}" for p in meta.get("params", [])
    )
    return_type = meta.get("return", {}).get("type", "void")

    lines = [
        f"id: {qid}",
        f"title: {problem['title']}",
        f"slug: {problem['titleSlug']}",
        f"difficulty: {problem['difficulty']}",
        f"funcName: {meta.get('name', 'solve')}",
        f"params: {params_str}",
        f"returnType: {return_type}",
        "---",
    ]

    for i, raw in enumerate(inputs_list):
        if i > 0:
            lines.append("")  # blank line between cases
        for input_line in raw.split("\n"):
            lines.append(input_line)
        expected = outputs[i] if i < len(outputs) else ""
        lines.append(f"= {expected}")

    os.makedirs(TESTCASES_DIR, exist_ok=True)
    path = os.path.join(TESTCASES_DIR, f"{qid}.txt")
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")
    return path


def write_dispatch(qid, title, func_name, params, return_type):
    """Write ProblemDispatch.swift for a single problem."""
    body = generate_dispatch_body(func_name, params, return_type)
    with open(DISPATCH_PATH, "w") as f:
        f.write(DISPATCH_TEMPLATE.format(title=title, body=body))


def update_runner_id(qid):
    """Update the problemID constant in Runner.swift."""
    with open(RUNNER_PATH, "r") as f:
        content = f.read()
    new = re.sub(r"let problemID = \d+", f"let problemID = {qid}", content)
    if new != content:
        with open(RUNNER_PATH, "w") as f:
            f.write(new)


# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main():
    if len(sys.argv) != 2 or not sys.argv[1].isdigit():
        print("Usage: python3 Scripts/gen_tests.py <question_number>")
        sys.exit(1)

    qid = sys.argv[1]
    print(f"Fetching question #{qid} from LeetCode...")

    problem = fetch_problem(qid)
    if not problem:
        print(f"Error: Question #{qid} not found.")
        sys.exit(1)

    meta = problem["metaData"]
    if not meta.get("params"):
        print(f"Error: No function metadata for [{qid}] {problem['title']}.")
        print("  This might be a design/class problem that needs manual test setup.")
        sys.exit(1)

    # 1. Write plain-text test cases
    txt_path = write_txt_testcases(qid, problem)

    # 2. Add txt to Xcode project (TestCases group)
    add_file_to_group(f"{qid}.txt", TESTCASES_GROUP_ID, file_type="text")

    # 3. Generate ProblemDispatch.swift for this problem only
    func_name = meta.get("name", "solve")
    params = meta.get("params", [])
    return_type = meta.get("return", {}).get("type", "void")
    write_dispatch(qid, problem["title"], func_name, params, return_type)

    # 4. Update Runner.swift
    update_runner_id(qid)

    n = len(problem["exampleTestcaseList"])
    print(f"  [{qid}] {problem['title']} ({problem['difficulty']})")
    print(f"  -> {os.path.relpath(txt_path, PROJECT_ROOT)}  ({n} test cases)")
    print(f"  -> ProblemDispatch.swift updated")
    print(f"  -> Runner.swift problemID = {qid}")
    print(f"\n  Run: Cmd+R in Xcode")


if __name__ == "__main__":
    main()
