/*
 * @lc app=leetcode id=914 lang=swift
 *
 * [914] X of a Kind in a Deck of Cards
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func hasGroupsSizeX(_ deck: [Int]) -> Bool {
        var mp = [Int: Int]()
        guard deck.count > 1 else { return false }
        for num in deck {
            mp[num, default: 0] += 1
        }
        func _gcd(_ a: Int, _ b: Int) -> Int {
            if b == 0 {
                return a
            }
            return _gcd(b, a % b)
        }
        var ans = -1
        for (_, v) in mp {
            if ans < 0 {
                ans = v
            } else {
                ans = _gcd(v, ans)
            }
        }
        return ans > 1
    }
}
// @lc code=end

