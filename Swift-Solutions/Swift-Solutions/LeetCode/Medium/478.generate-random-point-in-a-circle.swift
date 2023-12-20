/*
 * @lc app=leetcode id=478 lang=swift
 *
 * [478] Generate Random Point in a Circle
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {
    var (r, x0, y0) = (0.0, 0.0, 0.0)
}
#endif

extension Solution {

    convenience init(_ radius: Double, _ x_center: Double, _ y_center: Double) {
        self.init()
        (r, x0, y0) = (radius, x_center, y_center)
    }

    // (x - x0) * (x - x0) + (y - y0) * (y - y0) <= r * r
    // A point on the circumference of the circle is considered to be in the circle.
    // -> including borders
    func randPoint() -> [Double] {
        // 不够 random
//        let rx = Double.random(in: x0-r...x0+r)
//        let tmp = sqrt(r * r - (rx - x0) * (rx - x0))
//        let ry = Double.random(in: y0-tmp...y0+tmp)
//        return [rx, ry]

        // WA: rr = r * Double.random(in: 0.0...1.0) !!
        let rr = sqrt(r * r * Double.random(in: 0.0...1.0))
        let alpha = Double.random(in: 0..<2*Double.pi)
        return [x0 + rr * cos(alpha), y0 + rr * sin(alpha)]
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(radius, x_center, y_center)
 * let ret_1: [Double] = obj.randPoint()
 */
// @lc code=end

