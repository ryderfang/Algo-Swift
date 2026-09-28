/*
 * @lc app=leetcode id=386 lang=swift
 *
 * [386] Lexicographical Numbers
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    //
    // [1, n]
    func lexicalOrder(_ n: Int) -> [Int] {
        // 投机取巧的写法
//        return (1...n).map{ String($0) }.sorted().compactMap{ Int($0) }

        var ans = [Int]()
        func _getNext(_ cur: inout Int) -> Int {
            if cur * 10 <= n {
                cur *= 10
                return cur
            }
            if cur % 10 < 9 && cur + 1 <= n {
                cur += 1
                return cur
            }
            cur = cur / 10
            while cur % 10 >= 9 || cur + 1 > n {
                cur /= 10
            }
            if cur > 0 && cur + 1 <= n {
                cur += 1
                return cur
            }
            return 0
        }
        var t = 1
        ans.append(t)
        while _getNext(&t) > 0 {
            ans.append(t)
        }
        assert(ans.count == n)
        return ans
    }
}
// @lc code=end

