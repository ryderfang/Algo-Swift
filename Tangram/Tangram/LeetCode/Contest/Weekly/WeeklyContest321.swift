//
//  WeeklyContest.swift
//  Titan
//
//  Created by ryfang on 2022/11/26.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 2485
    func pivotInteger(_ n: Int) -> Int {
        // x(x+1)/2 = (n-x+1)(x+n)/2
        // x^2 + x = (n^2-x^2+n+x)
        // 2*x^2 = n^2+n
        // x = sqrt((n^2+n)/2)
        let target = (n * n + n) / 2
        let res = Int(sqrt(Double(target)))
        if res * res == target {
            return res
        } else {
            return -1
        }
    }

    // 2486
    func appendCharacters(_ s: String, _ t: String) -> Int {
        let s = Array(s)
        let t = Array(t)
        var count = t.count
        var i = 0, j = 0
        while i < t.count && j < s.count {
            if t[i] == s[j] {
                i += 1
                count -= 1
            }
            j += 1
        }
        return count
    }

    // 2487
    func removeNodes(_ head: ListNode?) -> ListNode? {
        guard let node = head else { return nil }
        var p: ListNode? = node
        var stack = [ListNode]()
        while p != nil {
            stack.append(p!)
            p = p?.next
        }
        var ans = [ListNode]()
        var maxi = stack.last!.val
        ans.append(stack.popLast()!)
        while stack.count > 0 {
            let last = stack.last!
            if last.val >= maxi {
                maxi = last.val
                ans.append(last)
            }
            stack.removeLast()
        }
        p = nil
        for x in ans {
            x.next = p
            p = x
        }
        return ans.last
    }

    // 2488
    func countSubarrays(_ nums: [Int], _ k: Int) -> Int {
        let n = nums.count
        guard n > 1 else { return 1 }
        var ki = 0
        // i <- [0, ki] greater[i] = i - less[i]
        // j <- (ki, n] greater[j] = j - 1 - less[j]
        // for [i, j)
        // greater[j] - greater[i] - (less[j] - less[i]) = [0, 1]
        // j - i - 1 - 2 * (less[j] - less[i])

        // less[i] is count of num < k for i ∈ [0..i)
        var less = [Int](repeating: 0, count: n+1)
        for (i, x) in nums.enumerated() {
            less[i+1] = less[i]
            if x == k {
                ki = i
                break
            } else if x < k {
                less[i+1] += 1
            }
        }
        var diff = [Int: Int]()
        // diff of [i...ki], i ∈ [0...ki]
        for i in 0...ki {
            // j = ki + 1
            let d = (ki + 1) - i - 1 - (less[ki+1] - less[i]) * 2
            diff[d, default: 0] += 1
        }
        var ans = diff[0, default: 0] + diff[1, default: 0]
        var offset = 0
        for j in ki+1..<n {
            if nums[j] > k {
                // less[j+1] == less[j]
                offset += 1
            } else {
                // less[j+1] == less[j] + 1
                offset -= 1
            }
            ans += diff[0-offset, default: 0] + diff[1-offset, default: 0]
        }
        return ans
    }
}
// @lc code=end
