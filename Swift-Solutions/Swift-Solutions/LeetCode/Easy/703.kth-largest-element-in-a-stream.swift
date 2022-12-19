/*
 * @lc app=leetcode id=703 lang=swift
 *
 * [703] Kth Largest Element in a Stream
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class KthLargest {
    private var k: Int
    private var nums: [Int]

    init(_ k: Int, _ nums: [Int]) {
        self.k = k
        self.nums = nums.sorted(by: >)
    }
    
    func add(_ val: Int) -> Int {
        var i = 0
        let n = nums.count
        while i < n && nums[i] > val {
            i += 1
        }
        nums.insert(val, at: i)
        return nums[k-1]
    }
}

/**
 * Your KthLargest object will be instantiated and called as such:
 * let obj = KthLargest(k, nums)
 * let ret_1: Int = obj.add(val)
 */
// @lc code=end

