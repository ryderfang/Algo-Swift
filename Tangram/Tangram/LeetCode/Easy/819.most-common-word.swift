/*
 * @lc app=leetcode id=819 lang=swift
 *
 * [819] Most Common Word
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func mostCommonWord(_ paragraph: String, _ banned: [String]) -> String {
        let banned: Set<String> = Set(banned)
        // get last word
        let paragraph = paragraph + " "
        var mp = [String: Int]()
        var str = ""
        for ch in paragraph {
            if ("a"..."z").contains(ch) || ("A"..."Z").contains(ch) {
                str.append(ch)
            } else {
                str = str.lowercased()
                if str.count > 0 && !banned.contains(str) {
                    mp[str, default: 0] += 1
                }
                str = ""
            }
        }
        var ans = "", count = 0
        for (k, v) in mp {
            if v > count {
                ans = k
                count = v
            }
        }
        return ans
    }
}
// @lc code=end

