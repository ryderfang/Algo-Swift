/*
 * @lc app=leetcode id=506 lang=swift
 *
 * [506] Relative Ranks
 */

// @lc code=start
class Solution {
    func findRelativeRanks(_ score: [Int]) -> [String] {
        var scoreWithRank = [(Int, Int)]()
        for (i, x) in score.enumerated() {
            scoreWithRank.append((i, x))
        }
        scoreWithRank.sort(by: {
            $0.1 > $1.1
        })
        var ans = [String](repeating: "", count: score.count)
        for (i, x) in scoreWithRank.enumerated() {
            var rank = ""
            switch i {
            case 0:
                rank = "Gold Medal"
            case 1:
                rank = "Silver Medal"
            case 2:
                rank = "Bronze Medal"
            default:
                rank = String(i + 1)
            }
            ans[x.0] = rank
        }
        return ans
    }
}
// @lc code=end

