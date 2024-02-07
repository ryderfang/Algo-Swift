/*
 * @lc app=leetcode id=1467 lang=swift
 *
 * [1467] Probability of a Two Boxes Having The Same Number of Distinct Balls
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func getProbability(_ balls: [Int]) -> Double {
        var (a, b) = (0.0, 0.0)
        let k = balls.count
        let n = balls.reduce(0, +) / 2
        // Int 会越界
        func _factorial(_ x: Int) -> Double {
            guard x > 0 else { return 1.0 }
            var ret = 1.0
            for i in 1...x {
                ret *= Double(i)
            }
            return ret
        }
        let fn = _factorial(n)

        func _dfs(_ i1: Int, _ box1: inout [Int]) {
            guard i1 < k else { return }
            if box1.reduce(0, +) == n {
                var (p1, p2) = (fn, fn)
                var box2 = balls
                for i in 0..<k {
                    p1 /= _factorial(box1[i])
                    box2[i] -= box1[i]
                    p2 /= _factorial(box2[i])
                }
                b += p1 * p2
                let c1 = box1.filter({ $0 > 0 }).count
                let c2 = box2.filter({ $0 > 0 }).count
                if c1 == c2 {
                    a += p1 * p2
                }
                return
            }
            if box1[i1] < balls[i1] {
                box1[i1] += 1
                _dfs(i1, &box1)
                box1[i1] -= 1
            }
            _dfs(i1 + 1, &box1)
        }
        var box1 = [Int](repeating: 0, count: k)
        _dfs(0, &box1)
        print(a, b)
        return Double(a) / Double(b)
    }
}
// @lc code=end
