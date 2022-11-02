/*
 * @lc app=leetcode id=303 lang=swift
 *
 * [303] Range Sum Query - Immutable
 */

// @lc code=start

class NumArray {
    private let nums: [Int]
    private var sumTo: [Int]

    init(_ nums: [Int]) {
        self.nums = nums
        sumTo = [Int](repeating: 0, count: nums.count)
        sumTo[0] = nums[0]
        for i in 1..<nums.count {
            sumTo[i] = sumTo[i-1] + nums[i]
        }
    }
    
    func sumRange(_ left: Int, _ right: Int) -> Int {
        return sumTo[right] - sumTo[left] + nums[left]
    }
}

/**
 * Your NumArray object will be instantiated and called as such:
 * let obj = NumArray(nums)
 * let ret_1: Int = obj.sumRange(left, right)
 */
// @lc code=end

