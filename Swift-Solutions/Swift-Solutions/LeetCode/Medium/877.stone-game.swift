/*
 * @lc app=leetcode id=877 lang=swift
 *
 * [877] Stone Game
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // 石子游戏
    // first pick always win!
    func stoneGame(_ piles: [Int]) -> Bool {
        true
    }

    func stoneGame1(_ piles: [Int]) -> Bool {
        let n = piles.count
        let sum = piles.reduce(0, +)
        var alice = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        var bob = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)
        func _bfs(_ i: Int, _ j: Int) -> Int {
            guard j >= i else { return 0 }
            let diff = j - i + 1
            if diff % 2 == 0 {
                // alice
                guard alice[i][j] == 0 else { return alice[i][j] }
                if diff == 2 {
                    alice[i][j] = max(piles[i], piles[j])
                } else {
                    alice[i][j] = max(piles[i] + _bfs(i+1, j), _bfs(i, j-1) + piles[j])
                }
                return alice[i][j]
            } else {
                // bob
                guard bob[i][j] == 0 else { return bob[i][j] }
                if diff == 1 {
                    bob[i][j] = piles[i]
                } else {
                    bob[i][j] = max(piles[i], _bfs(i+1, j), _bfs(i, j-1) + piles[j])
                }
                return bob[i][j]
            }
        }
        let maxAlice = _bfs(0, n-1)
        return maxAlice * 2 > sum
    }
}
// @lc code=end
