#!/usr/bin/env python3
"""
gen_tests.py - Generate test cases for a LeetCode problem.

Fetches example test cases from LeetCode, saves them as JSON, and registers
a dispatch entry in ProblemDispatch.swift for the Runner entry point.

Usage:  python3 Scripts/gen_tests.py <question_number>
"""

import json
import os
import re
import sys

from lc_common import PROJECT_ROOT, fetch_problem

RUNNER_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "Runner")
TESTCASES_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "TestCases")
DISPATCH_PATH = os.path.join(RUNNER_DIR, "ProblemDispatch.swift")
RUNNER_PATH = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "Runner.swift")

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
        r'<strong>Output:</strong>\s*(?:<span[^>]*>)?(.+?)(?:</span>|<strong>|\n|</pre>|</p >)',
        content,
    ):
        val = m.group(1).strip()
        for old, new in [("&quot;", '"'), ("&amp;", "&"), ("&lt;", "<"), ("&gt;", ">")]:
            val = val.replace(old, new)
        outputs.append(val)
    return outputs


def generate_dispatch_case(qid, title, func_name, params, return_type):
    """Generate a Swift `case N:` block for ProblemDispatch.swift."""
    args = ", ".join(
        INPUT_PARSERS.get(p["type"], "tc.string({i})").format(i=i)
        for i, p in enumerate(params)
    )
    call = f"sol.{func_name}({args})"
    expected_expr, style = EXPECTED_MAP.get(return_type, ("tc.expectedString", "equal"))

    if style == "void":
        body = f"                // void return - verify side effects manually\n                {call}"
    elif style in ("tree", "list"):
        body = (f"                let result = {call}\n"
                f"                check(result?.array() ?? [], {expected_expr}, "
                f"\"Case \\(i + 1)\", &passed, &failed)")
    elif style == "accuracy":
        body = (f"                checkAccuracy({call}, {expected_expr}, "
                f"accuracy: 1e-5, \"Case \\(i + 1)\", &passed, &failed)")
    else:
        body = (f"                check({call}, {expected_expr}, "
                f"\"Case \\(i + 1)\", &passed, &failed)")

    return (f"        case {qid}: // [{qid}] {title}\n"
            f"            for (i, tc) in cases.enumerated() {{\n{body}\n            }}")


# ---------------------------------------------------------------------------
# File generation
# ---------------------------------------------------------------------------

DISPATCH_HEADER = """\
//
//  ProblemDispatch.swift
//  Tangram
//
//  Auto-generated by gen_tests.py. Do not edit manually.
//

enum ProblemRunner {
    static func run(_ id: Int) {
        let sol = Solution()
        let cases = loadTestCases(id)
        guard !cases.isEmpty else {
            print("No test cases for problem #\\(id). Run: python3 Scripts/gen_tests.py \\(id)")
            return
        }

        print("--- Problem #\\(id) ---")
        var passed = 0, failed = 0

        switch id {
"""

DISPATCH_FOOTER = """\
        default:
            print("Problem #\\(id) not registered. Run: python3 Scripts/gen_tests.py \\(id)")
            return
        }

        print("\\(passed + failed) tests: \\(passed) passed, \\(failed) failed")
    }

    private static func check<T: Equatable>(_ got: T, _ expected: T, _ label: String, _ passed: inout Int, _ failed: inout Int) {
        if got == expected {
            passed += 1
            print("  \\(label) pass")
        } else {
            failed += 1
            print("  \\(label) FAIL  got: \\(got), expected: \\(expected)")
        }
    }

    private static func checkAccuracy(_ got: Double, _ expected: Double, accuracy: Double, _ label: String, _ passed: inout Int, _ failed: inout Int) {
        if abs(got - expected) <= accuracy {
            passed += 1
            print("  \\(label) pass")
        } else {
            failed += 1
            print("  \\(label) FAIL  got: \\(got), expected: \\(expected)")
        }
    }
}
"""


def write_json_testcases(qid, problem):
    """Write test case data to TestCases/<id>.json. Returns file path."""
    meta = problem["metaData"]
    inputs_list = problem["exampleTestcaseList"]
    outputs = parse_outputs_from_html(problem["content"])

    cases = [
        {"inputs": raw.split("\n"), "expected": outputs[i] if i < len(outputs) else ""}
        for i, raw in enumerate(inputs_list)
    ]
    data = {
        "id": int(qid), "title": problem["title"],
        "slug": problem["titleSlug"], "difficulty": problem["difficulty"],
        "funcName": meta.get("name", "solve"),
        "params": [{"name": p["name"], "type": p["type"]} for p in meta.get("params", [])],
        "returnType": meta.get("return", {}).get("type", "void"),
        "cases": cases,
    }

    os.makedirs(TESTCASES_DIR, exist_ok=True)
    path = os.path.join(TESTCASES_DIR, f"{qid}.json")
    with open(path, "w") as f:
        json.dump(data, f, indent=2, ensure_ascii=False)
    return path


def regenerate_dispatch():
    """Rebuild ProblemDispatch.swift from all TestCases/*.json files."""
    json_files = sorted(
        (f for f in os.listdir(TESTCASES_DIR) if f.endswith(".json")),
        key=lambda f: int(f.split(".")[0]),
    ) if os.path.isdir(TESTCASES_DIR) else []

    blocks = []
    for fname in json_files:
        with open(os.path.join(TESTCASES_DIR, fname)) as f:
            d = json.load(f)
        blocks.append(generate_dispatch_case(
            d["id"], d["title"], d["funcName"], d["params"], d["returnType"]))

    with open(DISPATCH_PATH, "w") as f:
        f.write(DISPATCH_HEADER)
        if blocks:
            f.write("\n".join(blocks) + "\n")
        f.write(DISPATCH_FOOTER)


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
    if not problem["metaData"].get("params"):
        print(f"Error: No function metadata for [{qid}] {problem['title']}.")
        print("  This might be a design/class problem that needs manual test setup.")
        sys.exit(1)

    json_path = write_json_testcases(qid, problem)
    regenerate_dispatch()
    update_runner_id(qid)

    n = len(problem["exampleTestcaseList"])
    print(f"  [{qid}] {problem['title']} ({problem['difficulty']})")
    print(f"  -> {os.path.relpath(json_path, PROJECT_ROOT)}  ({n} test cases)")
    print(f"  -> ProblemDispatch.swift updated")
    print(f"  -> Runner.swift problemID = {qid}")
    print(f"\n  Run: Cmd+R in Xcode")


if __name__ == "__main__":
    main()
