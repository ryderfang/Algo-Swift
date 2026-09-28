/*
 * @lc app=leetcode id=241 lang=swift
 *
 * [241] Different Ways to Add Parentheses
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func diffWaysToCompute(_ expression: String) -> [Int] {
        let exp = Array(expression)
        var nums = [Int]()
        var ops = [Character]()
        var (i, n) = (0, exp.count)
        while i < n {
            if ["+", "-", "*"].contains(exp[i]) {
                ops.append(exp[i])
                i += 1
                continue
            }
            var j = i
            var num = 0
            while j < n && !["+", "-", "*"].contains(exp[j]) {
                num = num * 10 + Int(String(exp[j]))!
                j += 1
            }
            i = j
            nums.append(num)
        }
        var ans = [Int]()
        n = nums.count
        func _diffWays(_ start: Int, _ end: Int) -> [Int] {
            guard end > start else { return [nums[start]] }
            var ret = [Int]()
            for i in start..<end {
                let d1 = _diffWays(start, i)
                let d2 = _diffWays(i + 1, end)
                ret.append(contentsOf: _doCompute(d1, d2, ops[i]))
            }
            return ret
        }
        func _doCompute(_ a: [Int], _ b: [Int], _ op: Character) -> [Int] {
            var ret = [Int]()
            for i in a {
                for j in b {
                    switch op {
                    case "+":
                        ret.append(i + j)
                    case "-":
                        ret.append(i - j)
                    case "*":
                        ret.append(i * j)
                    default:
                        break
                    }
                }
            }
            return ret
        }
        ans = _diffWays(0, n - 1)
        return Array(ans)
    }
}
// @lc code=end

