/*
 * @lc app=leetcode id=69 lang=swift
 *
 * [69] Sqrt(x)
 */

// @lc code=start
class Solution {
    /*
     let cases = [
         1,
         8,
         15,
         24,
         35,
         48,
         63,
         80,
         88,
         2147483647,
         2147395599,
     ]
    */
    // 牛顿法
    func mySqrt(_ x: Int) -> Int {
        let dx = Double(x)
        var x0 = (1 + dx) / 2
        while true {
            let x1 = (x0 + dx / x0) / 2
            // "1.13" as threshold. case:
            // 2147395599 -> 46339
            if x0 - x1 < 1.13 {
                x0 = x1
                break
            }
            x0 = x1
        }
        return Int(x0)
    }

    // 二分
    func mySqrt1(_ x: Int) -> Int {
        var l = 0, r = x
        while l < r {
            let m = l + (r - l) / 2
            if m * m <= x && (m + 1) * (m + 1) > x {
                return m
            } else if m * m > x  {
                r = m - 1
            } else {
                l = m + 1
            }
        }
        return l
    }

    // 库函数
    func mySqrt2(_ x: Int) -> Int {
        return Int(sqrt(Double(x)))
    }
}
// @lc code=end

