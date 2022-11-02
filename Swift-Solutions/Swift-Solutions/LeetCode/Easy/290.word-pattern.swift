/*
 * @lc app=leetcode id=290 lang=swift
 *
 * [290] Word Pattern
 */

// @lc code=start
class Solution {
    func wordPattern(_ pattern: String, _ s: String) -> Bool {
        let pArray: [String] = pattern.map { String($0) }
        let pLen = pArray.count
        let sArray: [String] = s.components(separatedBy: " ")
        let sLen = sArray.count
        guard pLen == sLen else { return false }
        var pMap = [String: String]()
        var sMap = [String: String]()
        for i in 0..<pLen {
            if pMap[pArray[i]] == nil {
                guard sMap[sArray[i]] == nil else {
                    return false
                }
                pMap[pArray[i]] = sArray[i]
                sMap[sArray[i]] = pArray[i]
            } else {
                guard pMap[pArray[i]] == sArray[i] else {
                    return false
                }
            }
        }
        return true
    }
}
// @lc code=end

