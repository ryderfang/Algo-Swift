/*
 * @lc app=leetcode id=1047 lang=swift
 *
 * [1047] Remove All Adjacent Duplicates In String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func removeDuplicates(_ s: String) -> String {
        let n = s.count
        guard n > 1 else { return s }
        let str = s.map { String($0) }
        var stack = [String]()
        var i = 0
        while i < n {
            guard let top = stack.last else {
                stack.append(str[i])
                i += 1
                continue
            }
            if top == str[i] {
                stack.removeLast()
            } else {
                stack.append(str[i])
            }
            
            i += 1
        }
        return stack.joined()
    }
}
// @lc code=end
