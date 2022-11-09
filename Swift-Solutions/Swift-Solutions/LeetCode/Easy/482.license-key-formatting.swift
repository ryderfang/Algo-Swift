/*
 * @lc app=leetcode id=482 lang=swift
 *
 * [482] License Key Formatting
 */

// @lc code=start
class Solution {
    func licenseKeyFormatting(_ s: String, _ k: Int) -> String {
        let components = s.components(separatedBy: "-").joined().uppercased()
        let arr: [Character] = Array(components)
        let n = arr.count
        var ans = [String]()
        for i in stride(from: n - 1, through: k - 1, by: -k) {
            ans.append(String(arr[i-k+1...i]))
        }
        if n % k != 0 {
            ans.append(String(arr[0..<n%k]))
        }
        return ans.reversed().joined(separator: "-")
    }
}
// @lc code=end

