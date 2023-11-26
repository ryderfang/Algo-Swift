/*
 * @lc app=leetcode id=384 lang=swift
 *
 * [384] Shuffle an Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {
    var arr: [Int] = []
}
#endif

// n ~ [1, 50]
extension Solution {
    convenience init(_ nums: [Int]) {
        self.init()
        self.arr = nums
    }
    
    func reset() -> [Int] {
        return self.arr
    }
    
    func shuffle() -> [Int] {
        var ans = [Int]()
        var tmp = self.arr
        let n = tmp.count
        var k = n
        while k > 0 {
            let rx = Int.random(in: 0..<k)
            ans.append(tmp[rx])
            tmp.swapAt(rx, k-1)
            k -= 1
        }
        return ans
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: [Int] = obj.reset()
 * let ret_2: [Int] = obj.shuffle()
 */
// @lc code=end

