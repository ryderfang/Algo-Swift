/*
 * @lc app=leetcode id=335 lang=swift
 *
 * [335] Self Crossing
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution
    /* 3 options to cross
     - [1,1,1,2]
     - [1,1,2,1,1]
     - [1,1,2,2,1,1]
     */
    func isSelfCrossing(_ x: [Int]) -> Bool {
        let n = x.count
        guard n > 3 else { return false }
        for i in 3..<n {
            if x[i] >= x[i-2] && x[i-1] <= x[i-3] {
                return true
            }
            if i >= 4 && x[i-1] == x[i-3] && x[i] + x[i-4] >= x[i-2] {
                return true
            }
            if i >= 5 && x[i-2] >= x[i-4] && x[i-5] + x[i-1] >= x[i-3] &&
                x[i-1] <= x[i-3] && x[i-4] + x[i] >= x[i-2] {
                return true
            }
        }
        return false
    }


    func isSelfCrossing1(_ distance: [Int]) -> Bool {
        let n = distance.count
        guard n > 3 else { return false }
        // y: [x1 -> x2]
        var hor = [Int: [(Int, Int)]]()
        // x: [y1 -> y2]
        var ver = [Int: [(Int, Int)]]()
        func _check(_ x: Int, _ y: Int, _ direct: Int, _ dis: Int) -> Bool {
            var ret = true
            switch direct {
            case 0:
                // 上
                var minY = Int.max
                for (y1, _) in ver[x, default: []] {
                    if y1 > y {
                        minY = min(minY, y1)
                    }
                }
                for (y1, v) in hor {
                    if y1 > y {
                        var cross = false
                        for (x1, x2) in v {
                            if x1 <= x && x <= x2 {
                                cross = true
                                break
                            }
                        }
                        if cross {
                            minY = min(minY, y1)
                        }
                    }
                }
                ret = (minY - y > dis)
            case 1:
                // 左
                var maxX = Int.min
                for (_, x1) in hor[y, default: []] {
                    if x1 < x {
                        maxX = max(maxX, x1)
                    }
                }
                for (x1, v) in ver {
                    if x1 < x {
                        var cross = false
                        for (y1, y2) in v {
                            if y1 <= y && y <= y2 {
                                cross = true
                                break
                            }
                        }
                        if cross {
                            maxX = max(maxX, x1)
                        }
                    }
                }
                ret = (x - maxX > dis)
            case 2:
                // 下
                var maxY = Int.min
                for (y1, _) in ver[x, default: []] {
                    if y1 < y {
                        maxY = max(maxY, y1)
                    }
                }
                for (y1, v) in hor {
                    if y1 < y {
                        var cross = false
                        for (x1, x2) in v {
                            if x1 <= x && x <= x2 {
                                cross = true
                                break
                            }
                        }
                        if cross {
                            maxY = max(maxY, y1)
                        }
                    }
                }
                ret = (y - maxY > dis)
            case 3:
                // 右
                var minX = Int.max
                for (_, x1) in hor[y, default: []] {
                    if x1 > x {
                        minX = min(minX, x1)
                    }
                }
                for (x1, v) in ver {
                    if x1 > x {
                        var cross = false
                        for (y1, y2) in v {
                            if y1 <= y && y <= y2 {
                                cross = true
                                break
                            }
                        }
                        if cross {
                            minX = min(minX, x1)
                        }
                    }
                }
                ret = (minX - x > dis)
            default:
                break
            }
            return ret
        }

        var (x0, y0) = (0, 0)
        var ans = false
        for i in 0..<n {
            guard !ans else { break }
            let dis = distance[i]
            var check = (i < 3) || (distance[i-1] > distance[i-3])
            switch i % 4 {
            case 0:
                if !check {
                    check = _check(x0, y0, 0, dis)
                }
                if check {
                    ver[x0, default: []].append((y0, y0 + dis))
                    y0 += dis
                } else {
                    ans = true
                }
            case 1:
                if !check {
                    check = _check(x0, y0, 1, dis)
                }
                if check {
                    hor[y0, default: []].append((x0 - dis, x0))
                    x0 -= dis
                } else {
                    ans = true
                }
            case 2:
                if !check {
                    check = _check(x0, y0, 2, dis)
                }
                if check {
                    ver[x0, default: []].append((y0 - dis, y0))
                    y0 -= dis
                } else {
                    ans = true
                }
            case 3:
                if !check {
                    check = _check(x0, y0, 3, dis)
                }
                if check {
                    hor[y0, default: []].append((x0, x0 + dis))
                    x0 += dis
                } else {
                    ans = true
                }
                break
            default:
                break
            }
        }
        return ans
    }
}
// @lc code=end
