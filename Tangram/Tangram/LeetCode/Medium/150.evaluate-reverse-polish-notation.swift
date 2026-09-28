/*
 * @lc app=leetcode id=150 lang=swift
 *
 * [150] Evaluate Reverse Polish Notation
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for x in tokens {
            if let num = Int(x) {
                stack.append(num)
            } else {
                let op1 = stack.removeLast()
                let op2 = stack.removeLast()
                switch x {
                case "+":
                    stack.append(op2 + op1)
                case "-":
                    stack.append(op2 - op1)
                case "*":
                    stack.append(op2 * op1)
                case "/":
                    stack.append(op2 / op1)
                default:
                    break
                }
            }
        }
        return stack.last!
    }
}
// @lc code=end

