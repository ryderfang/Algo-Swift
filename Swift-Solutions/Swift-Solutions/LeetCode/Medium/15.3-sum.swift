/*
 * @lc app=leetcode id=15 lang=swift
 *
 * [15] 3Sum
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func threeSum(_ nums: [Int]) -> [[Int]] {
        // x : count
        var mp = [Int: Int]()
        var m_nums = [Int]()
        for x in nums {
            // 优化：避免 TLE
            // 同一个数字最多只需要出现三次
            var count = mp[x, default: 0]
            count += 1
            if count <= 3 {
                m_nums.append(x)
            }
            mp[x] = min(count, 3)
        }
        let n = m_nums.count
        var ans = Set<[Int]>()
        for i in 0..<n-1 {
            for j in i+1..<n {
                let target = -m_nums[i]-m_nums[j]
                let count = mp[target, default: 0]
                guard count > 0 else { continue }
                var check = true
                if target == m_nums[i] || target == m_nums[j] {
                    if !(m_nums[i] == m_nums[j] && count == 3) &&
                        !(m_nums[i] != m_nums[j] && count == 2) {
                        check = false
                    }
                }
                if check {
                    let pair = [m_nums[i], m_nums[j], target].sorted()
                    ans.insert(pair)
                }
            }
        }
        return Array(ans)
    }
}
// @lc code=end

