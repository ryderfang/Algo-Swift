/*
 * @lc app=leetcode id=202 lang=swift
 *
 * [202] Happy Number
 */

// @lc code=start
extension Solution {
    // can opt by slow-fast pointer..
    func isHappy(_ n: Int) -> Bool {
        guard n > 1 else { return true }
        func _digits(_ n: Int) -> [Int] {
            let d: [Int] = String(n).map { Int(String($0))! }
            return d
        }
        func _next(_ d: [Int]) -> Int {
            return d.reduce(0) { $0 + $1 * $1 }
        }
        func _number(_ d: [Int]) -> Int {
            return Int(d.map { String($0) }.joined())!
        }
        var loop = 0
        var num = n
        var ds = _digits(num)
        while loop < 10 {
            num = _next(ds)
            print(num)
            if num == 1 || num == 4 {
                break
            }
            ds = _digits(num)
            loop += 1
        }
        return num == 1
    }
}
// @lc code=end

