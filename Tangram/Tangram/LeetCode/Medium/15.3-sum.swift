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
        let nums = nums.sorted()
        let n = nums.count
        guard n >= 3 else { return [] }
        var ans = [[Int]]()
        for i in 0..<n {
            // 相同数字只取第一个
            if i > 0 && nums[i] == nums[i-1] { continue }
            // target = 0
            let x = 0 - nums[i]
            var l = i + 1, r = n - 1
            // two-pointer
            while l < r {
                let sum = nums[l] + nums[r]
                if sum == x {
                    ans.append([nums[i], nums[l], nums[r]])
                    // 找到一个之后继续，可能还有其他组合
                    l += 1
                    r -= 1
                    // 去重
                    while l < r && nums[l] == nums[l-1] { l += 1 }
                    while l < r && nums[r] == nums[r+1] { r -= 1 }
                } else {
                    // 排序的好处
                    sum > x ? r -= 1 : (l += 1)
                }
            }
        }
        return ans
    }

    func _threeSum(_ nums: [Int]) -> [[Int]] {
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

