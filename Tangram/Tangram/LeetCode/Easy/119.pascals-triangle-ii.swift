/*
 * @lc app=leetcode id=119 lang=swift
 *
 * [119] Pascal's Triangle II
 */

// @lc code=start

// 杨辉三角
extension Solution {
    func getRow(_ rowIndex: Int) -> [Int] {
        if rowIndex == 0 {
            return [1]
        } else {
            var ans = [Int](repeating: 1, count: rowIndex+1)
            for i in 1...rowIndex {
                ans[i] = ans[i-1] * (rowIndex - i + 1) / i
            }
            return ans
        }
    }

    func getRow1(_ rowIndex: Int) -> [Int] {
        if rowIndex == 0 {
            return [1]
        } else if rowIndex == 1 {
            return [1, 1]
        } else {
            let last = getRow(rowIndex - 1)
            var ans = [1]
            for i in 1..<last.count {
                ans.append(last[i] + last[i-1])
            }
            ans.append(1)
            return ans
        }
    }
}
// @lc code=end

