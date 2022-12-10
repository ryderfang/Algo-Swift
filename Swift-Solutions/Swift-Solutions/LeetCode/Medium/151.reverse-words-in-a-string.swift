/*
 * @lc app=leetcode id=151 lang=swift
 *
 * [151] Reverse Words in a String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func reverseWords(_ s: String) -> String {
        let components = s.split(separator: " ")
//        var components: [String] = s.components(separatedBy: " ")
//        components = components
//            .map { ele in
//                var start = ele.startIndex
//                while start != ele.endIndex && ele[start] == " " {
//                    start = ele.index(after: start)
//                }
//                if start != ele.endIndex {
//                    return String(ele[start..<ele.endIndex])
//                } else {
//                    return nil
//                }
//            }
//            .compactMap { $0 }
        return components.reversed().joined(separator: " ")
    }
}
// @lc code=end

