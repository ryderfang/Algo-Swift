/*
 * @lc app=leetcode id=1021 lang=swift
 *
 * [1021] Remove Outermost Parentheses
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func removeOuterParentheses(_ s: String) -> String {
        let str = s.map { String($0) }
        let n = str.count
        var stack = [String]()
        var tmp = [String]()
        var ans = [String]()
        for i in 0..<n {
            tmp.append(str[i])
            if str[i] == "(" {
                stack.append(str[i])
            } else {
                if !stack.isEmpty {
                    stack.removeLast()
                }
                // found
                if stack.isEmpty {
                    if tmp.count > 2 {
                        tmp.removeFirst()
                        tmp.removeLast()
                        ans.append(contentsOf: tmp)
                    }
                    tmp = []
                }
            }
        }
        return ans.joined()
    }
}
// @lc code=end
