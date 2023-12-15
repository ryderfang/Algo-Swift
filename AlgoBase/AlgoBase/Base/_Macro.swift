//
//  MyMacro.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/2.
//

var g_start_time = NSDate()
public func TICK() { g_start_time = NSDate() }
public func TOCK(function: String = #function) {
    print(String(format: "[%@] cost: %.3lf s", function, -g_start_time.timeIntervalSinceNow))
}

// MARK: 分类
/*
1. Geometry 几何
https://leetcode.com/tag/geometry/

2. Combinatorics 组合
https://leetcode.com/tag/combinatorics/

3. Data-Structures 数据结构

4. Baisc-Algorithm 基础算法

5. Number-Theory 数论
https://leetcode.com/tag/number-theory/

6. Math 数学 / 数值计算
https://leetcode.com/tag/math/

7. Graph-Theory 图论
https://leetcode.com/tag/graph/

8. Classic 经典应用

*/
