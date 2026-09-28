/*
 * @lc app=leetcode id=393 lang=swift
 *
 * [393] UTF-8 Validation
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func validUtf8(_ data: [Int]) -> Bool {
        func _bytes(_ x: Int) -> Int {
            // 0xxxxxxx
            if (x >> 7) == 0 {
                return 0
            }
            // "110xxxxx"
            if (x >> 5) == 6 {
                return 1
            }
            // "1110xxxx"
            if (x >> 4) == 14 {
                return 2
            }
            // "11110xxx"
            if (x >> 3) == 30 {
                return 3
            }
            return -1
        }
        func _checkNext(_ x: Int) -> Bool {
            return (x >> 6) == 2
        }
        let n = data.count
        var (i, ans) = (0, true)
        while i < n {
            var next = _bytes(data[i])
            guard next >= 0 else {
                ans = false
                break
            }
            i += 1
            while next > 0 && i < n {
                guard _checkNext(data[i]) else { break }
                i += 1
                next -= 1
            }
            if next > 0 {
                ans = false
            }
            if !ans {
                break
            }
            i += next
        }
        return ans
    }
}
// @lc code=end
