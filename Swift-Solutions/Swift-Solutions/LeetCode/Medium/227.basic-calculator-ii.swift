/*
 * @lc app=leetcode id=227 lang=swift
 *
 * [227] Basic Calculator II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func _doCalc(_ n1: Int, _ n2: Int, _ op: Character) -> Int {
        switch op {
        case "+":
            return n2 + n1
        case "-":
            return n2 - n1
        case "*":
            return n2 * n1
        case "/":
            return n2 / n1
        default:
            fatalError("invalid op")
        }
    }


    func calculate(_ s: String) -> Int {
        var nums = [Int]()
        var op = [Character]()
        let exp = [Character](s)
        let n = exp.count
        var i = 0
        while i < n {
            if exp[i].isDigit() {
                var digit = 0
                while i < n, let iVal = exp[i].digit() {
                    digit = digit * 10 + iVal
                    i += 1
                }
                nums.append(digit)
                continue
            }

            switch exp[i] {
            case "+":
                fallthrough
            case "-":
                while let top = op.popLast() {
                    let (n1, n2) = (nums.removeLast(), nums.removeLast())
                    nums.append(_doCalc(n1, n2, top))
                }
                op.append(exp[i])
            case "*":
                fallthrough
            case "/":
                while let top = op.last {
                    guard top == "*" || top == "/" else { break }
                    let (n1, n2) = (nums.removeLast(), nums.removeLast())
                    nums.append(_doCalc(n1, n2, top))
                    op.removeLast()
                }
                op.append(exp[i])
            case " ":
                break
            default:
                break
            }
            i += 1
        }
        while let top = op.popLast() {
            let (n1, n2) = (nums.removeLast(), nums.removeLast())
            nums.append(_doCalc(n1, n2, top))

        }
        return nums.last!
    }
}

fileprivate extension Character {
    func isDigit() -> Bool {
       return ("0"..."9").contains(self)
    }

    func digit() -> Int? {
        guard let intValue = Int(String(self)) else {
            return nil
        }
        return intValue
    }
}

// @lc code=end

