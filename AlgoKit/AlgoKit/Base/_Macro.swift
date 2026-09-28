//
//  MyMacro.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/2.
//

import Foundation

var g_start_time = NSDate()
public func TICK() { g_start_time = NSDate() }
public func TOCK(function: String = #function) {
    print(String(format: "[%@] cost: %.3lf s", function, -g_start_time.timeIntervalSinceNow))
}

// MARK: 分类
/**
1. Geometry 几何
[✓] https://leetcode.com/tag/geometry/

2. Combinatorics 组合
[✓] https://leetcode.com/tag/combinatorics/

3. Data-Structures 数据结构
https://leetcode.com/tag/array/
https://leetcode.com/tag/string/
https://leetcode.com/tag/hash-table/
https://leetcode.com/tag/stack/
https://leetcode.com/tag/queue/
https://leetcode.com/tag/monotonic-stack/
https://leetcode.com/tag/linked-list/
https://leetcode.com/tag/heap-priority-queue/ 🌟🌟
https://leetcode.com/tag/trie/ 🌟
https://leetcode.com/tag/segment-tree/ 🌟🌟
https://leetcode.com/tag/binary-indexed-tree/ (BIT)
https://leetcode.com/tag/tree/
https://leetcode.com/tag/prefix-sum/
https://leetcode.com/tag/binary-tree/
https://leetcode.com/tag/binary-search-tree/
https://leetcode.com/tag/union-find/ 🌟🌟

4. Baisc-Algorithm 基础算法 🌟🌟🌟🌟
[=] https://leetcode.com/tag/sorting/
https://leetcode.com/tag/greedy/ 🌟
https://leetcode.com/tag/divide-and-conquer/ 🌟
https://leetcode.com/tag/binary-search/ 🌟🌟
https://leetcode.com/tag/depth-first-search/ 🌟🌟🌟
https://leetcode.com/tag/breadth-first-search/ 🌟🌟🌟
https://leetcode.com/tag/dynamic-programming/ 🌟🌟🌟🌟🌟
https://leetcode.com/tag/backtracking/ 🌟🌟

5. Number-Theory 数论
https://leetcode.com/tag/number-theory/

6. Math 数学 / 数值计算
https://leetcode.com/tag/math/
https://leetcode.com/tag/bit-manipulation/

7. Graph-Theory 图论
https://leetcode.com/tag/graph/

8. Classic 经典应用
https://leetcode.com/tag/game-theory/
https://leetcode.com/tag/two-pointers/
https://leetcode.com/tag/sliding-window/
https://leetcode.com/tag/memoization/

**/
