/*
 * @lc app=leetcode id=933 lang=swift
 *
 * [933] Number of Recent Calls
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class RecentCounter {
    var times = [Int]()
    var count = 0
    var start = 0

    init() {
        
    }
    
    func ping(_ t: Int) -> Int {
        times.append(t)
        count += 1
        var i = start
        while i < count && times[i] < t - 3000 {
            i += 1
        }
        start = i
        return count - start
    }
}

/**
 * Your RecentCounter object will be instantiated and called as such:
 * let obj = RecentCounter()
 * let ret_1: Int = obj.ping(t)
 */
// @lc code=end

