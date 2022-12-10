/*
 * @lc app=leetcode id=278 lang=swift
 *
 * [278] First Bad Version
 */

// @lc code=start
/**
 * The knows API is defined in the parent class VersionControl.
 *     func isBadVersion(_ version: Int) -> Bool{}
 */

extension Solution : VersionControl {
    private func firstBadVersion(_ n: Int) -> Int {
        var left = 1, right = n
        while left < right {
            let mid = left + (right - left) / 2
            if !isBadVersion(mid) {
                left = mid + 1
            } else {
                right = mid
            }
        }
        if isBadVersion(left) {
            return left
        } else {
            return left + 1
        }
    }
}
// @lc code=end

