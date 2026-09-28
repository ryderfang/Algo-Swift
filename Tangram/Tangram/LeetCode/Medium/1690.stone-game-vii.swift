/*
 * @lc app=leetcode id=1690 lang=swift
 *
 * [1690] Stone Game VII
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func stoneGameVII(_ stones: [Int]) -> Int {
        let n = stones.count
        var preSum = [Int](repeating: 0, count: n)
        for i in 0..<n {
            preSum[i] = (i == 0 ? stones[0] : preSum[i-1] + stones[i])
        }
        func _rangeSum(_ i: Int, _ j: Int) -> Int {
            guard i > 0 else { return preSum[j] }
            return preSum[j] - preSum[i-1]
        }
        var mem = [[Int]](repeating: [Int](repeating: -1, count: n), count: n)
        func _solve(_ st: Int, _ ed: Int) -> Int {
            guard mem[st][ed] < 0 else { return mem[st][ed] }
            let cnt = ed - st + 1
            if cnt <= 1 {
                mem[st][ed] = 0
                return 0
            } else if cnt == 2 {
                mem[st][ed] = max(stones[st], stones[ed])
                return mem[st][ed]
            } else {
                /* alice pick first */
                // bob will pick less diff then
                var alice1 = _rangeSum(st + 1, ed)
                let bob1 = _solve(st + 2, ed) - _rangeSum(st + 2, ed)
                let bob2 = _solve(st + 1, ed - 1) - _rangeSum(st + 1, ed - 1)
                alice1 += min(bob1, bob2)
                /* alice pick last */
                var alice2 = _rangeSum(st, ed - 1)
                let bob3 = _solve(st + 1, ed - 1) - _rangeSum(st + 1, ed - 1)
                let bob4 = _solve(st, ed - 2) - _rangeSum(st, ed - 2)
                alice2 += min(bob3, bob4)

                mem[st][ed] = max(alice1, alice2)
            }
            return mem[st][ed]
        }
        let ans = _solve(0, n-1)
        return ans
    }
}
// @lc code=end

