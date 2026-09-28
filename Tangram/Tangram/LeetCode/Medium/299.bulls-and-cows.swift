/*
 * @lc app=leetcode id=299 lang=swift
 *
 * [299] Bulls and Cows
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func getHint(_ secret: String, _ guess: String) -> String {
        var a1 = [Int](repeating: 0, count: 10)
        var a2 = [Int](repeating: 0, count: 10)
        let n = secret.count
        var (bull, cow) = (0, 0)
        for i in 0..<n {
            if secret[i] == guess[i] {
                bull += 1
            } else {
                a1[secret[i]] += 1
                a2[guess[i]] += 1
            }
        }
        for i in 0..<10 {
            cow += min(a1[i], a2[i])
        }
        return "\(bull)A\(cow)B"
    }
}

fileprivate extension String {
    subscript (i: Int) -> Int {
        guard let v = Int(String(self[self.index(self.startIndex, offsetBy: i)] as Character)) else { return 0 }
        return v
    }
}
// @lc code=end

