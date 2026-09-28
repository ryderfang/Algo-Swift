/*
 * @lc app=leetcode id=77 lang=swift
 *
 * [77] Combinations
 */

// @lc code=start
extension Solution {
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var ans = [[Int]]()
        func _p(_ index: Int, _ res: [Int]) {
            if res.count == k {
                ans.append(res)
                return
            }
            for i in index..<n {
                if n - i < k - res.count {
                    break
                }
                var tmp = res
                tmp.append(i + 1)
                _p(i + 1, tmp)
                tmp.removeLast()
            }
        }
        _p(0, [])
        return ans
    }
}
// @lc code=end

