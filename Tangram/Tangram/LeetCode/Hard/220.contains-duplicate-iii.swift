/*
 * @lc app=leetcode id=220 lang=swift
 *
 * [220] Contains Duplicate III
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // MARK: TODO
    /* Bucket sort: O(n)
     * if valueDiff = 3
     * bucket[0] = 0, 1, 2, 3
     * bucket[1] = 4, 5, 6, 7
     ...
    */
    func containsNearbyAlmostDuplicate(_ nums: [Int], _ indexDiff: Int, _ valueDiff: Int) -> Bool {
        let n = nums.count
        let minVal = min(nums.min() ?? 0, 0)
        // make all nums non-negative
        let nums = nums.map { $0 + minVal }
        var bucket = [Int: Int]()
        for i in 0..<n {
            let idx = nums[i] / (valueDiff + 1)
            if bucket[idx] != nil {
                // same bucket always <= valueDiff
                return true
            } else {
                bucket[idx] = nums[i]
                // check neighbors
                if let x = bucket[idx-1], nums[i] - x <= valueDiff {
                    return true
                }
                if let x = bucket[idx+1], x - nums[i] <= valueDiff {
                    return true
                }
                // remove first
                if bucket.count > indexDiff {
                    let first = nums[i-indexDiff] / (valueDiff + 1)
                    bucket.removeValue(forKey: first)
                }
            }
        }
        return false
    }

    // O(n^2)
    func containsNearbyAlmostDuplicate1(_ nums: [Int], _ indexDiff: Int, _ valueDiff: Int) -> Bool {
        let n = nums.count
        let ids = [Int](0..<n).sorted(by: { nums[$0] < nums[$1] })
        for i in 0..<n-1 {
            for j in i+1..<n {
                let lhs = ids[i], rhs = ids[j]
                if nums[rhs] - nums[lhs] > valueDiff { break }
                if abs(rhs - lhs) <= indexDiff { return true }
            }
        }
        return false
    }
}
// @lc code=end
