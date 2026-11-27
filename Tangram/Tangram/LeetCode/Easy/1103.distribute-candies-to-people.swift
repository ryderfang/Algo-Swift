/*
 * @lc app=leetcode id=1103 lang=swift
 *
 * [1103] Distribute Candies to People
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func distributeCandies(_ candies: Int, _ num_people: Int) -> [Int] {
        let oneRound = (1 + num_people) * num_people / 2
        var round = 0
        var remain = candies
        var ans = [Int](repeating: 0, count: num_people)
        var offset = 0
        while remain > 0 {
            let curRound = offset * num_people + oneRound
            remain -= curRound
            if remain <= 0 {
                remain += curRound
                break
            }
            for i in 0..<num_people {
                ans[i] += offset + (i + 1)
            }
            round += 1
            offset = round * num_people
        }
        for i in 0..<num_people {
            if (remain - offset - (i + 1)) >= 0 {
                ans[i] += offset + i + 1
                remain -= (offset + i + 1)
            } else {
                if remain > 0 {
                    ans[i] += remain
                }
                break
            }
        }
        return ans
    }
}
// @lc code=end
