/*
 * @lc app=leetcode id=1002 lang=swift
 *
 * [1002] Find Common Characters
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func commonChars(_ words: [String]) -> [String] {
        let n = words.count
        let asci_a = Character("a").asciiValue!
        var map = [[Int]](repeating: [Int](repeating: 0, count: 26), count: n)
        for i in 0..<n {
            for ch in words[i] {
                let idx = Int(ch.asciiValue! - asci_a)
                map[i][idx] = map[i][idx] + 1
            }
        }
        var ans = [String]()
        for i in 0..<26 {
            var count = Int.max
            for j in 0..<n {
                count = min(count, map[j][i])
            }
            ans.append(contentsOf: [String](repeating: String(UnicodeScalar(UInt8(i) + asci_a)), count: count))
        }
        return ans
    }
}
// @lc code=end

