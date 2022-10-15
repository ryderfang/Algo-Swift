/*
 * @lc app=leetcode id=66 lang=swift
 *
 * [66] Plus One
 */

// @lc code=start
extension Solution {
    // 大整数加法
    func plusOne(_ digits: [Int]) -> [Int] {
        var carry = 1
        var ans: [Int] = digits.reversed()
        for i in 0..<ans.count {
            let sum = ans[i] + carry
            ans[i] = sum % 10
            carry = sum / 10
            if carry == 0 {
                break
            }
        }
        if carry > 0 {
            ans.append(carry)
        }
        return [Int](ans.reversed())
    }
}
// @lc code=end

