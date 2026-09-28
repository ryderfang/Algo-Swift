/*
 * @lc app=leetcode id=492 lang=swift
 *
 * [492] Construct the Rectangle
 */

// @lc code=start
extension Solution {
    func constructRectangle(_ area: Int) -> [Int] {
        guard area > 3 else { return [area, 1] }
        let squareRoot = Int(floor(sqrt(Double(area))))
        var L = area, M = 1
        for i in 2...squareRoot {
            if area % i == 0 {
                M = i
                L = area / M
            }
        }
        return [L, M]
    }
}
// @lc code=end

