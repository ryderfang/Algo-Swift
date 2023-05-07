/*
 * @lc app=leetcode id=229 lang=swift
 *
 * [229] Majority Element II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 扩展的投票算法
    func majorityElement(_ nums: [Int]) -> [Int] {
        let n = nums.count
        let limit = n / 3
        var (p1, c1) = (Int.min, 0)
        var (p2, c2) = (Int.min, 0)
        for x in nums {
            if p1 == x {
                c1 += 1
                continue
            }
            if p2 == x {
                c2 += 1
                continue
            }
            if c1 == 0 {
                p1 = x
                c1 = 1
                continue
            }
            if c2 == 0 {
                p2 = x
                c2 = 1
                continue
            }
            c1 -= 1
            c2 -= 1
        }
        (c1, c2) = (0, 0)
        for x in nums {
            if x == p1 {
                c1 += 1
            } else if x == p2 {
                c2 += 1
            }
        }
        var ans = [Int]()
        if c1 > limit {
            ans.append(p1)
        }
        if c2 > limit {
            ans.append(p2)
        }
        return ans
    }

    func majorityElement2_1(_ nums: [Int]) -> [Int] {
        let n = nums.count
        let limit = n / 3
        var mp = [Int: Int]()
        for x in nums {
            mp[x, default: 0] += 1
        }
        var ans = [Int]()
        for (k, v) in mp {
            if v > limit {
                ans.append(k)
            }
        }
        return ans
    }
}
// @lc code=end

