/*
 * @lc app=leetcode id=347 lang=swift
 *
 * [347] Top K Frequent Elements
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // O(nlogn)
    func topKFrequent1(_ nums: [Int], _ k: Int) -> [Int] {
        var mp = [Int: Int]()
        for x in nums {
            mp[x, default: 0] += 1
        }
        return Array(mp.sorted(by: { $0.value > $1.value })
                    .map{ $0.key }[0..<k])
    }

    // Better solution: Bucket sort (桶排序）
    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        let n = nums.count
        var mp = [Int: Int]()
        for x in nums {
            mp[x, default: 0] += 1
        }
        var bucket = [[Int]](repeating: [Int](), count: n + 1)
        for (num, freq) in mp {
            bucket[freq].append(num)
        }
        var ans = [Int]()
        for i in (1...n).reversed() {
            ans.append(contentsOf: bucket[i])
            if ans.count == k {
                break
            }
        }
        return ans
    }
}
// @lc code=end

