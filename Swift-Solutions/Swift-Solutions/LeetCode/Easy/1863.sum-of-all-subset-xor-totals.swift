/*
 * @lc app=leetcode id=1863 lang=swift
 *
 * [1863] Sum of All Subset XOR Totals
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution
    func subsetXORSum(_ nums: [Int]) -> Int {
        let n = nums.count
        var ans = 0
        func _helper(_ xor: Int, _ start: Int) {
            guard start < n else { return }
            let nextXor = xor ^ nums[start]
            ans += nextXor
            _helper(xor, start + 1)
            _helper(nextXor, start + 1)
        }
        _helper(0, 0)
        return ans
    }

    // 2 <= total <= 2^12 = 4096
    func subsetXORSum1(_ nums: [Int]) -> Int {
        var ans = 0
        var subSets = [[Int]]()
        subSets.append([])
        subSets = nums.reduce(into: subSets, {
            r, c in
            r = r + r.map { $0 + [c] }
        })
        for a in subSets {
            guard a.count > 0 else { continue }
            var tmp = 0
            for i in 0..<a.count {
                if i > 0 {
                    tmp ^= a[i]
                } else {
                    tmp = a[i]
                }
            }
            ans += tmp
        }
        return ans
    }
}
// @lc code=end

