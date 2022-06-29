/*
 * @lc app=leetcode id=60 lang=swift
 *
 * [60] Permutation Sequence
 */

// @lc code=start
extension Solution {
    func getPermutation(_ n: Int, _ k: Int) -> String {
        // index to code
        var tmp = k - 1
        var L = [Int](repeating: 0, count: n)
        for i in (0..<n-1).reversed() {
            L[i] = tmp % (n - i)
            tmp /= (n - i)
        }
        // code to permutation
        var nums = [Int](repeating: 0, count: n)
        func _check(_ i: Int, _ valid: inout Int, _ map: inout [Int]) -> Bool {
            for j in 0..<i {
                if map[j] == 0 && nums[j] <= valid {
                    valid += 1
                    map[j] = 1
                    return false
                }
            }
            return true
        }
        
        nums[0] = L[0] + 1
        for i in 1..<n {
            var tmp = L[i] + 1
            var mp = [Int](repeating: 0, count: i)
            while !_check(i, &tmp, &mp) {}
            nums[i] = tmp
        }
        return nums.map({ String($0) }).joined()
    }
}
// @lc code=end

