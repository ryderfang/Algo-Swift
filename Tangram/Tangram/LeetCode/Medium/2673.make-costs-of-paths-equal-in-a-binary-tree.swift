/*
 * @lc app=leetcode id=2673 lang=swift
 *
 * [2673] Make Costs of Paths Equal in a Binary Tree
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func minIncrements(_ n: Int, _ cost: [Int]) -> Int {
        var costLeaf = [Int](repeating: 0, count: n)
        // 0-indexed i -> left: 2 * i + 1, right: 2 * i + 2
        func _curCost(_ i: Int) -> Int {
            guard costLeaf[i] == 0 else { return costLeaf[i] }
            // leaf
            if 2 * i + 1 >= n {
                costLeaf[i] = cost[i]
                return costLeaf[i]
            }
            costLeaf[i] = max(_curCost(2 * i + 1), _curCost(2 * i + 2)) + cost[i]
            return costLeaf[i]
        }
        func _minInc(_ i: Int, _ target: Int) -> Int {
            if 2 * i + 1 >= n {
                return target - cost[i]
            }
            let addRoot = target - _curCost(i)
            return addRoot + _minInc(2 * i + 1, _curCost(i) - cost[i]) +
            _minInc(2 * i + 2, _curCost(i) - cost[i])
        }
        return _minInc(0, _curCost(0))
    }
}
// @lc code=end

