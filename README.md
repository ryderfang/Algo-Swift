# Algo-Swift

![Swift](https://img.shields.io/badge/Swift-%23FF4088.svg?&style=for-the-badge&logo=swift&logoColor=white)

LeetCode solutions and algorithm templates in Swift.

![LeetCode Stats](https://leetcard.jacoblin.cool/ryderfang?theme=light&font=Fjord%20One&ext=activity&width=555)


## Project Structure

```
Algo-Swift.xcworkspace
├── AlgoKit/                    # Reusable algorithm & data-structure library
│   └── Base/                   #   Geometry, Combinatorics, Data Structures,
│                               #   Sorting, Number Theory, Math, Graph, Classics
├── Tangram/                    # LeetCode workspace
│   └── Tangram/
│       ├── LeetCode/           #   Solutions (Easy / Medium / Hard / Contest)
│       ├── Runner/             #   Test runner infrastructure
│       │   ├── Defines.swift   #     Solution class, AlgoKit re-exports
│       │   ├── ProblemDispatch.swift  # (auto-generated)
│       │   └── TestCaseLoader.swift   # JSON test-case parser
│       ├── Runner.swift        #   @main entry point
│       └── TestCases/          #   Test data (*.json, auto-generated)
├── Scripts/
│   ├── lc_common.py            # Shared LeetCode API client
│   ├── gen_leetcode.py         # Solution file generator
│   ├── gen_tests.py            # Test case generator
│   └── patch_leetcode_ext.sh   # VSCode extension patch
└── lc                          # CLI entry point (see below)
```

## Quick Start

```bash
# Generate a solution template + test cases for problem 42
./lc 42

# Open Algo-Swift.xcworkspace, write your solution, then Cmd+R to run tests
```

## CLI Reference

The `lc` command is the single entry point for all code generation.

```
./lc <id>              Generate solution file + test cases, set Runner to <id>
./lc <id> [id ...]     Batch generate solution files only (no test setup)
./lc test <id>         Regenerate test cases + set Runner (solution already exists)
```

### Examples

```bash
./lc 1                 # Start "Two Sum" — creates solution + 3 test cases
./lc 42                # Start "Trapping Rain Water"
./lc test 42           # Re-fetch test cases for problem 42
./lc 100,101,102       # Batch scaffold three tree problems
```

## AlgoKit

Reusable algorithm and data-structure library, extracted from problem-solving patterns:

- **Data Structures** — TreeNode, ListNode, Trie, Union-Find, BIT, Segment Tree
- **Algorithms** — Sorting (O(n^2), O(n log n), O(n)), Binary Search, BFS/DFS
- **Math** — Geometry, Combinatorics, Number Theory
- **Classics** — Knapsack, LIS, Matrix Exponentiation

References:
- [raywenderlich/swift-algorithm-club](https://github.com/raywenderlich/swift-algorithm-club)
- [SunZhiC/DataStructuresInSwift](https://github.com/SunZhiC/DataStructuresInSwift)

## VSCode-LeetCode Extension Patch

To fix the `redeclaration of 'Solution'` issue when using the VSCode LeetCode extension:

```bash
./Scripts/patch_leetcode_ext.sh
```

<details>
<summary><b>Manual fix</b></summary>

Path: `~/.vscode/extensions/leetcode.vscode-leetcode-0.18.1`

1. Add `LC_SOLUTION_EXT` to **Custom Flags** in Xcode Build Settings

2. Change template — `node_modules/vsc-leetcode-cli/templates/codeonly.tpl`

```
${comment.start}
${comment.line} @lc app=${app} id=${fid} lang=${lang}
${comment.line}
${comment.line} [${fid}] ${name}
${comment.end}

${comment.singleLine} @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

${code}
${comment.singleLine} @lc code=end
```

3. Patch `node_modules/vsc-leetcode-cli/lib/core.js` — add before `return file.render(...)`:

```js
data.code = data.code.replace(/class Solution/g, 'extension Solution');
```

</details>

### 📚 Books

![](https://ryder-1252249141.cos.ap-shanghai.myqcloud.com/uPic/2022-11-15-ZoByQo.png)

I bought several books about algorithm years ago, mostly writen by Liu Rujia (as known as [@srbga](https://www.topcoder.com/members/srbga)).

> Of course never finished reading them :(

Now I'm going to rewrite codes in these books with Swift.

Let's Go! 🖖
