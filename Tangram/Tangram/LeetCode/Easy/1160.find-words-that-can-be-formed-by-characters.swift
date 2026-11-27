/*
 * @lc app=leetcode id=1160 lang=swift
 *
 * [1160] Find Words That Can Be Formed by Characters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func countCharacters(_ words: [String], _ chars: String) -> Int {
        func _genHash(_ word: String) -> [Character: Int] {
            var ret = [Character: Int]()
            for ch in word {
                ret[ch] = ret[ch, default: 0] + 1
            }
            return ret
        }
        let hash = _genHash(chars)
        var ans = 0
        for w in words {
            let tmp = _genHash(w)
            var check = true
            for (k,v) in tmp {
                if v > hash[k, default: 0] {
                    check = false
                    break
                }
            }
            if check {
                ans += w.count
            }
        }
        return ans
    }
}
// @lc code=end
