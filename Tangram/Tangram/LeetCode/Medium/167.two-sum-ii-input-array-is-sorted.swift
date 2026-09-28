/*
 * @lc app=leetcode id=167 lang=swift
 *
 * [167] Two Sum II - Input Array Is Sorted
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func twoSum(_ numbers: [Int], _ target: Int) -> [Int] {
        func _search(_ target: Int, _ left: Int, _ right: Int) -> Int {
            var left = left, right = right
            while left <= right {
                let mid = (left + right) / 2
                if numbers[mid] == target {
                    return mid
                } else if numbers[mid] < target {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
            return -1
        }
        let n = numbers.count
        for i in 0..<n-1 {
            if i > 0 && numbers[i] == numbers[i-1] {
                continue
            }
            let another = _search(target - numbers[i], i + 1, n - 1)
            if another > 0 {
                return [i + 1, another + 1]
            }
        }
        return [-1, -1]
    }
}
// @lc code=end

