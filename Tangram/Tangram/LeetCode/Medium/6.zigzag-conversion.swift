/*
 * @lc app=leetcode id=6 lang=swift
 *
 * [6] Zigzag Conversion
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // zigzag -> line by line
    func convert(_ s: String, _ numRows: Int) -> String {
        guard numRows > 1 else { return s }
        let a: [Character] = Array(s)
        let n = a.count
        var zz: [[Character]] = [[Character]](repeating: [Character](), count: numRows)
        var i = 0
        var row = 0
        var down = true
        while i < n {
            if down {
                if row < numRows - 1 {
                    zz[row].append(a[i])
                    row += 1
                } else {
                    down = false
                    zz[row].append(a[i])
                    row -= 1
                }
            } else {
                if row > 0 {
                    zz[row].append(a[i])
                    row -= 1
                } else {
                    down = true
                    zz[row].append(a[i])
                    row += 1
                }
            }
            i += 1
        }
        return zz.map{ String($0) }.joined()
    }
}
// @lc code=end

