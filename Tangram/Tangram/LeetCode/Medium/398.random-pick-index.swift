/*
 * @lc app=leetcode id=398 lang=swift
 *
 * [398] Random Pick Index
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {
    var mp: [Int: [Int]] = [:]
}
#endif

extension Solution {
    convenience init(_ nums: [Int]) {
        self.init()
        let n = nums.count
        for i in 0..<n {
            self.mp[nums[i], default: []].append(i)
        }
    }

    func pick(_ target: Int) -> Int {
        let idxs = mp[target, default: []]
        let n = idxs.count
        guard n > 0 else { return -1 }
        return idxs[Int.random(in: 0..<n)]
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: Int = obj.pick(target)
 */
// @lc code=end

