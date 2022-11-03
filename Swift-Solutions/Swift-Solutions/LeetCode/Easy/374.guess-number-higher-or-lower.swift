/*
 * @lc app=leetcode id=374 lang=swift
 *
 * [374] Guess Number Higher or Lower
 */

// @lc code=start
/** 
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return 	     -1 if num is higher than the picked number
 *			      1 if num is lower than the picked number
 *               otherwise return 0 
 * func guess(_ num: Int) -> Int 
 */

extension Solution : GuessGame {
    func guessNumber(_ n: Int) -> Int {
        var l = 1, r = n
        while l <= r {
            let m = l + (r - l) / 2
            let res = guess(m)
            if res == 0 {
                return m
            } else if res < 0 {
                r = m - 1
            } else {
                l = m + 1
            }
        }
        return l
    }
}
// @lc code=end

