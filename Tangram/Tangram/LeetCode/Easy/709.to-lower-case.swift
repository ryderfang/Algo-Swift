/*
 * @lc app=leetcode id=709 lang=swift
 *
 * [709] To Lower Case
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func toLowerCase(_ s: String) -> String {
        return String(s.map { $0.toLower() })
    }
}

fileprivate extension Character {
    func toLower() -> Character {
        guard let ascii = self.asciiValue, ascii >= 65 && ascii <= 90 else { return self }
        return Character(UnicodeScalar(ascii + 32))
    }
}

// @lc code=end
