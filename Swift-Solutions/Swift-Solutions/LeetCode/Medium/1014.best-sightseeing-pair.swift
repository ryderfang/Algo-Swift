/*
 * @lc app=leetcode id=1014 lang=swift
 *
 * [1014] Best Sightseeing Pair
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    /*
    * (v[i] + i) + (v[j] - j)
    * For every j, find max i
    */
    func maxScoreSightseeingPair(_ values: [Int]) -> Int {
        var value = 0
        var prevMax = values[0]
        for i in 1..<values.count {
            let score = values[i]
            value = max(value, prevMax + score - i)
            prevMax = max(prevMax, score + i)
        }
        return value
    }

    func maxScoreSightseeingPair1(_ values: [Int]) -> Int {
        let n = values.count
        func _solve(_ i: Int, _ j: Int) -> Int {
            guard i < j else { return Int.min }
            // [i, m] [m+1, j]
            let m = (i + j) / 2
            var ret = Int.min
            ret = max(ret, _solve(i, m), _solve(m + 1, j))
            // find max index of left
            var (tmp, k) = (Int.min, m)
            var inc = 0 // offset from m
            for s in (i...m).reversed() {
                if tmp < values[s] - inc {
                    tmp = values[s] - inc
                    k = s
                }
                inc += 1
            }
            // m+1 -> j
            for s in m+1...j {
                ret = max(ret, values[k] + values[s] + k - s)
            }
            return ret
        }
        let ans = _solve(0, n-1)
        return ans
    }
}
// @lc code=end

