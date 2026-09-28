/*
 * @lc app=leetcode id=744 lang=swift
 *
 * [744] Find Smallest Letter Greater Than Target
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func nextGreatestLetter(_ letters: [Character], _ target: Character) -> Character {
        let n = letters.count
        var l = 0, r = n - 1
        let targetAscii = target.asciiValue!
        while l <= r {
            let m = l + (r - l) / 2
            if letters[m] == target {
                break
            }
            if letters[m].asciiValue! < targetAscii {
                l = m + 1
            } else {
                r = m - 1
            }
        }
        while l < n && letters[l].asciiValue! <= targetAscii {
            l += 1
        }
        return l == n ? letters[0] : letters[l]
    }
}
// @lc code=end

