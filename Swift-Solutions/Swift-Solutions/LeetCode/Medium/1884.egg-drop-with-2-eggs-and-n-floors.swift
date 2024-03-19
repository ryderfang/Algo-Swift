/*
 * @lc app=leetcode id=1884 lang=swift
 *
 * [1884] Egg Drop With 2 Eggs and N Floors
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func twoEggDrop(_ n: Int) -> Int {
        Int(round(sqrt(Double(n*2))))
    }

    func twoEggDrop1(_ n: Int) -> Int {
        var ans = [Int](repeating: 0, count: n + 1)
        // optional
        var dropIdx = [Int](repeating: 0, count: n + 1)
        func _twoEggDrop(_ n: Int) -> Int {
            guard n > 0 else { return 0 }
            guard ans[n] == 0 else { return ans[n] }
            var ret = n, idx = 0
            for i in 1...n {
                // drop egg1 at i
                // if break, f < i
                var count = 1 + i - 1
                // if not break, f >= i
                count = max(count, 1 + _twoEggDrop(n - i))
                if ret > count {
                    idx = i
                    ret = min(ret, count)
                }
            }
            ans[n] = ret
            dropIdx[n] = idx
            return ret
        }
        let ret = _twoEggDrop(n)
        return ret
    }
}
// @lc code=end
