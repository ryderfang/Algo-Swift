/*
 * @lc app=leetcode id=89 lang=swift
 *
 * [89] Gray Code
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func grayCode(_ n: Int) -> [Int] {
        // 低位到高位
        func _bitsToInt(_ bs: [Int]) -> Int {
            var ans = 0
            var base = 1
            for b in bs {
                ans += b * base
                base *= 2
            }
            return ans
        }

        // 00000
        // 00001
        // 00011
        // 00010
        // 00110
        // 00111
        // 00101
        // 00100
        // 01100
        func _generateNext(_ bits: inout [Int], _ visit: inout [Int]) -> Int {
            guard let i = visit.firstIndex(where: { $0 == 0 }) else { return -1 }
            // change first not visited bit
            bits[i] = 1 - bits[i]
            visit[i] = 1
            // clean visit before i
            for j in 0..<i {
                visit[j] = 0
            }
            // print(bits)
            return _bitsToInt(bits)
        }

        var bits = [Int](repeating: 0, count: n)
        var visit = [Int](repeating: 0, count: n)
        var ans = [Int]()
        let count: Int = Int(pow(2.0, Double(n)))
        ans.append(0)
        for _ in 1..<count {
            ans.append(_generateNext(&bits, &visit))
        }
        return ans
    }
}
// @lc code=end

