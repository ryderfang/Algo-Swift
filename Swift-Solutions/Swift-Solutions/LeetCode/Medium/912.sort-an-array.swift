/*
 * @lc app=leetcode id=912 lang=swift
 *
 * [912] Sort an Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func sortArray(_ nums: [Int]) -> [Int] {
        let n = nums.count
        guard n > 1 else { return nums }
        let mid = n / 2
        let leftArray = sortArray(Array(nums[0..<mid]))
        let rightArray = sortArray(Array(nums[mid..<n]))
        return _merge(leftArray, rightArray)
    }

    // merge two sorted array
    func _merge(_ leftPile: [Int], _ rightPile: [Int]) -> [Int] {
        var (leftIndex, rightIndex) = (0, 0)
        var orderedPile = [Int]()
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
        while true {
            guard leftIndex < leftPile.endIndex else {
                orderedPile.append(contentsOf: rightPile[rightIndex..<rightPile.endIndex])
                break
            }
            guard rightIndex < rightPile.endIndex else {
                orderedPile.append(contentsOf: leftPile[leftIndex..<leftPile.endIndex])
                break
            }
            if leftPile[leftIndex] < rightPile[rightIndex] {
                orderedPile.append(leftPile[leftIndex])
                leftIndex += 1
            } else {
                orderedPile.append(rightPile[rightIndex])
                rightIndex += 1
            }
        }
        return orderedPile
    }
}
// @lc code=end
