//
//  WeeklyContest371.swift
//  Titan
//
//  Created by ryfang on 2023/11/12.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maximumStrongPairXor1(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        let n = nums.count
        var ans = 0
        for i in 0..<n {
            for j in i..<n {
                if nums[j] <= 2 * nums[i] {
                    ans = max(ans, nums[i] ^ nums[j])
                }
            }
        }
        return ans
    }

    func findHighAccessEmployees(_ access_times: [[String]]) -> [String] {
        var times = [String: [Int]]()
        for x in access_times {
            let u = x[0]
            let t = Array(x[1]).map { Int(String($0))! }
            let secs = (t[0] * 10 + t[1]) * 60 + t[2] * 10 + t[3]
            times[u, default: []].append(secs)
        }
        var ans = [String]()
        for (u, t) in times {
            let tt = t.sorted()
            guard tt.count >= 3 else { continue }
            for i in 0...tt.count-3 {
                if tt[i+2] - tt[i] < 60 {
                    ans.append(u)
                    break
                }
            }
        }
        return ans
    }

    func minOperations(_ nums1: [Int], _ nums2: [Int]) -> Int {
        let n = nums1.count
        func _solve(_ nums1: [Int], _ nums2: [Int]) -> Int {
            var can = true
            var count = 0
            var nums3 = nums1
            var nums4 = nums2
            let m1 = nums3[n-1]
            let m2 = nums4[n-1]
            for i in 0..<n-1 {
                if nums3[i] > m1 {
                    // swap i if possible
                    if nums3[i] > m2 || nums4[i] > m1 {
                        can = false
                        break
                    }
                    let t = nums3[i]
                    nums3[i] = nums4[i]
                    nums4[i] = t
                    count += 1
                }
            }
            if !can {
                return Int.max - 1
            }

            for i in 0..<n-1 {
                if nums4[i] > m2 {
                    // swap i if possible
                    if nums4[i] > m1 || nums3[i] > m2 {
                        can = false
                        break
                    }
                    let t = nums3[i]
                    nums3[i] = nums4[i]
                    nums4[i] = t
                    count += 1
                }
            }
            if !can {
                return Int.max - 1
            }
            return count
        }
        var nums3 = nums1
        var nums4 = nums2
        swap(&nums3[n-1], &nums4[n-1])
        let ans = min(_solve(nums1, nums2), _solve(nums3, nums4) + 1)
        if ans >= Int.max - 1 {
            return -1
        }
        return ans
    }

    func maximumStrongPairXor(_ nums: [Int]) -> Int {
        let nums = nums.sorted()
        func _search(_ target: Int) -> Int {
            var l = 0, r = nums.count
            while l < r {
                let m = l + (r - l) / 2
                if nums[m] < target {
                    l = m + 1
                } else {
                    r = m
                }
            }
            var ret = l
            if ret == nums.count {
                ret -= 1
            }
            if nums[ret] > target {
                ret -= 1
            }
            return ret
        }
        var ans = 0
        let n = nums.count
        for i in 0..<n-1 {
            let x = nums[i]
            let y = _search(x << 1)
            for j in i...y {
                ans = max(ans, x ^ nums[j])
            }
        }
        return ans
    }
}

// @lc code=end
