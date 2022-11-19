/*
 * @lc app=leetcode id=22 lang=swift
 *
 * [22] Generate Parentheses
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func generateParenthesis(_ n: Int) -> [String] {
        guard n > 1 else { return ["()"] }
        var ans = Set<String>()
        let last = generateParenthesis(n - 1)
        for s in last {
            let len = s.count
            for i in 0...len {
                for j in i+1...len+1 {
                    var tmp = s
                    tmp.insert("(", at: tmp.index(tmp.startIndex, offsetBy: i))
                    tmp.insert(")", at: tmp.index(tmp.startIndex, offsetBy: j))
                    ans.insert(tmp)
                }
            }
        }
        return Array(ans)
    }
}
// @lc code=end

