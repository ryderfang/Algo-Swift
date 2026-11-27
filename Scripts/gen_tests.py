#!/usr/bin/env python3
"""
gen_tests.py - Generate test cases for a LeetCode problem.

Fetches example test cases from LeetCode, saves them as plain-text, and
generates ProblemDispatch.swift with only the current problem's dispatch entry.

Usage:  python3 Scripts/gen_tests.py <question_number> [question_number ...]
"""

import json
import os
import re
import sys

from lc_common import (
    PROJECT_ROOT,
    fetch_problem,
    parse_ids,
    swift_snippet,
    add_file_to_group,
    DIFFICULTY_GROUP_IDS,
)

RUNNER_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "Runner")
TESTCASES_DIR = os.path.join(PROJECT_ROOT, "Tangram", "Tangram", "TestCases")
DISPATCH_PATH = os.path.join(RUNNER_DIR, "ProblemDispatch.swift")
RUNNER_PATH = os.path.join(RUNNER_DIR, "Runner.swift")

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


def normalize_type(t):
    """LeetCode writes some arrays as list<...>: list<list<integer>> -> integer[][]."""
    m = re.fullmatch(r"list<(.+)>", t)
    return normalize_type(m.group(1)) + "[]" if m else t


def lookup(table, t, default):
    key = normalize_type(t)
    if key not in table:
        print(f"  Warning: unsupported type '{t}', falling back to string.",
              file=sys.stderr)
    return table.get(key, default)


def detect_inout_indices(func_name, swift_code, meta):
    """Return the set of 0-based parameter indices marked `inout` in Swift."""
    indices = set()
    if swift_code:
        m = re.search(rf"func\s+{re.escape(func_name)}\s*\(([^)]*)\)", swift_code)
        if m:
            raw_params = m.group(1).strip()
            if raw_params:
                for i, part in enumerate(raw_params.split(",")):
                    if re.search(r":\s*inout\b", part):
                        indices.add(i)
    out_idx = meta.get("output", {}).get("paramindex")
    if isinstance(out_idx, int):
        indices.add(out_idx)
    return indices


def generate_dispatch_body(func_name, params, return_type, inout_indices=None, output_param_index=None):
    """Generate the assertion body inside a for-loop over test cases."""
    inout_indices = inout_indices or set()
    prep_lines = []
    call_args = []
    for i, p in enumerate(params):
        expr = lookup(INPUT_PARSERS, p["type"], "tc.string({i})").format(i=i)
        if i in inout_indices:
            var_name = p.get("name") or f"arg{i}"
            prep_lines.append(f"            var {var_name} = {expr}")
            call_args.append(f"&{var_name}")
        else:
            call_args.append(expr)

    args = ", ".join(call_args)
    call = f"sol.{func_name}({args})"
    expected_expr, style = lookup(EXPECTED_MAP, return_type,
                                  ("tc.expectedString", "equal"))

    prefix = ("\n".join(prep_lines) + "\n") if prep_lines else ""

    if style == "void":
        target_idx = output_param_index
        if target_idx is None and len(inout_indices) == 1:
            target_idx = next(iter(inout_indices))
        if target_idx is not None and 0 <= target_idx < len(params) and target_idx in inout_indices:
            target_var = params[target_idx].get("name") or f"arg{target_idx}"
            out_expected, out_style = lookup(
                EXPECTED_MAP, params[target_idx]["type"], (None, "void")
            )
            if out_expected and out_style in ("tree", "list"):
                return (f"{prefix}"
                        f"            {call}\n"
                        f"            if !tc.expected.isEmpty {{\n"
                        f"                check({target_var}?.array() ?? [], {out_expected}, "
                        f"\"Case \\(i + 1)\", &passed, &failed)\n"
                        f"            }}")
            if out_expected and out_style == "equal":
                return (f"{prefix}"
                        f"            {call}\n"
                        f"            if !tc.expected.isEmpty {{\n"
                        f"                check({target_var}, {out_expected}, "
                        f"\"Case \\(i + 1)\", &passed, &failed)\n"
                        f"            }}")
        return f"{prefix}            // void return - verify side effects manually\n            {call}"
    elif style in ("tree", "list"):
        return (f"{prefix}"
                f"            let result = {call}\n"
                f"            check(result?.array() ?? [], {expected_expr}, "
                f"\"Case \\(i + 1)\", &passed, &failed)")
    elif style == "accuracy":
        return (f"{prefix}"
                f"            checkAccuracy({call}, {expected_expr}, "
                f"accuracy: 1e-5, \"Case \\(i + 1)\", &passed, &failed)")
    else:
        return (f"{prefix}"
                f"            check({call}, {expected_expr}, "
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
    """Write test case data to TestCases/<difficulty>/<id>.txt in plain-text format.

    An existing file is kept as is (it may hold hand-added cases).
    Returns (path, written).

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
    path = os.path.join(TESTCASES_DIR, problem["difficulty"], f"{qid}.txt")
    if os.path.exists(path):
        return path, False

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

    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")
    return path, True


def write_dispatch(qid, title, func_name, params, return_type, inout_indices=None, output_param_index=None):
    """Write ProblemDispatch.swift for a single problem."""
    body = generate_dispatch_body(
        func_name,
        params,
        return_type,
        inout_indices=inout_indices,
        output_param_index=output_param_index,
    )
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

def setup_tests(qid, set_runner=True):
    """Write test cases for one problem; optionally point the Runner at it.

    Returns True on success.
    """
    print(f"Fetching question #{qid} from LeetCode...")

    problem = fetch_problem(qid)
    if not problem:
        print(f"Error: Question #{qid} not found.")
        return False

    meta = problem["metaData"]
    if not meta.get("params"):
        print(f"Error: No function metadata for [{qid}] {problem['title']}.")
        print("  This might be a design/class problem that needs manual test setup.")
        return False

    # 1. Write plain-text test cases
    txt_path, written = write_txt_testcases(qid, problem)

    # 2. Add txt to Xcode project (TestCases/<difficulty> group)
    difficulty = problem["difficulty"]
    group_id = DIFFICULTY_GROUP_IDS["TestCases"].get(difficulty, TESTCASES_GROUP_ID)
    add_file_to_group(f"{qid}.txt", group_id, file_type="text")

    n = len(problem["exampleTestcaseList"])
    status = f"{n} test cases" if written else "already exists, kept"
    print(f"  [{qid}] {problem['title']} ({problem['difficulty']})")
    print(f"  -> {os.path.relpath(txt_path, PROJECT_ROOT)}  ({status})")
    if not set_runner:
        return True

    # 3. Generate ProblemDispatch.swift for this problem only
    func_name = meta.get("name", "solve")
    params = meta.get("params", [])
    return_type = meta.get("return", {}).get("type", "void")
    inout_indices = detect_inout_indices(func_name, swift_snippet(problem), meta)
    output_param_index = meta.get("output", {}).get("paramindex")
    write_dispatch(
        qid,
        problem["title"],
        func_name,
        params,
        return_type,
        inout_indices=inout_indices,
        output_param_index=output_param_index if isinstance(output_param_index, int) else None,
    )

    # 4. Update Runner.swift
    update_runner_id(qid)

    print(f"  -> ProblemDispatch.swift updated")
    print(f"  -> Runner.swift problemID = {qid}")
    return True


def main():
    ids = sorted(parse_ids(sys.argv[1:]), key=int)
    if not ids:
        print("Usage: python3 Scripts/gen_tests.py <question_number> [question_number ...]")
        sys.exit(1)

    # ProblemDispatch.swift holds a single problem, so the Runner targets the
    # first ID that sets up successfully; the rest only get test case files.
    runner_id = None
    ok = 0
    for i, qid in enumerate(ids):
        if i:
            print()
        if setup_tests(qid, set_runner=runner_id is None):
            ok += 1
            runner_id = runner_id or qid
    if len(ids) > 1:
        print(f"\nDone: {ok} set up, {len(ids) - ok} failed.")
        if runner_id:
            print(f"  Runner targets #{runner_id}. Switch with: ./lc test <id>")
    if not ok:
        sys.exit(1)
    print(f"\n  Run: Cmd+R in Xcode")


if __name__ == "__main__":
    main()
