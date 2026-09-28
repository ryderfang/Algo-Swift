/*
 * @lc app=leetcode id=20 lang=swift
 *
 * [20] Valid Parentheses
 */

// @lc code=start
extension Solution {
    func isValid(_ s: String) -> Bool {
        var stack: [Character] = []
        var ret = true
        for ch in s {
            if ch == "(" || ch == "[" || ch == "{" {
                stack.append(ch)
            } else {
                guard let top = stack.last else {
                    ret = false
                    break
                }
                switch ch {
                case ")":
                    if top != "(" {
                        ret = false
                        break
                    }
                case "]":
                    if top != "[" {
                        ret = false
                        break
                    }
                case "}":
                    if top != "{" {
                        ret = false
                        break
                    }
                default:
                    break
                }
                if !ret {
                    break
                }
                stack.removeLast()
            }
        }
        if !stack.isEmpty {
            ret = false
        }
        return ret
    }
}
// @lc code=end

