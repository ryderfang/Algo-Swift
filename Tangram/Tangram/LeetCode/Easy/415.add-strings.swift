/*
 * @lc app=leetcode id=415 lang=swift
 *
 * [415] Add Strings
 */

// @lc code=start
extension Solution {
    // bit integer add
    func addStrings(_ num1: String, _ num2: String) -> String {
        var nums1: [Int] = num1.reversed().map { Int(String($0))! }
        var nums2: [Int] = num2.reversed().map { Int(String($0))! }
        var sum = [Int]()
        let n = max(nums1.count, nums2.count)
        nums1.append(contentsOf: [Int](repeating: 0, count: n - nums1.count))
        nums2.append(contentsOf: [Int](repeating: 0, count: n - nums2.count))
        var carry = 0
        for i in 0..<n {
            let total = nums1[i] + nums2[i] + carry
            sum.append(total % 10)
            carry = total / 10
        }
        if carry > 0 {
            sum.append(carry)
        }
        return sum.reversed().map { String($0) }.joined()
    }
}
// @lc code=end

