/*
 * @lc app=leetcode id=989 lang=swift
 *
 * [989] Add to Array-Form of Integer
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func addToArrayForm(_ num: [Int], _ k: Int) -> [Int] {
        var kArray = [Int]()
        var k = k
        while k > 0 {
            kArray.append(k % 10)
            k /= 10
        }
        var num: [Int] = num.reversed()
        let n = max(num.count, kArray.count)
        num.append(contentsOf: [Int](repeating: 0, count: n - num.count))
        kArray.append(contentsOf: [Int](repeating: 0, count: n - kArray.count))
        var carry = 0
        var ans = [Int]()
        for i in 0..<n {
            let sum = num[i] + kArray[i] + carry
            ans.append(sum % 10)
            carry = sum / 10
        }
        if carry > 0 {
            ans.append(carry)
        }
        return ans.reversed()
    }
}
// @lc code=end

