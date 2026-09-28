/*
 * @lc app=leetcode id=804 lang=swift
 *
 * [804] Unique Morse Code Words
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let n = words.count
        guard n > 1 else { return n }
        let morse = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        var ans = Set<String>()
        for s in words {
            var trans = ""
            for ch in s {
                trans += morse[Int(ch.asciiValue! - Character("a").asciiValue!)]
            }
            ans.insert(trans)
        }
        return ans.count
    }
}

// @lc code=end

