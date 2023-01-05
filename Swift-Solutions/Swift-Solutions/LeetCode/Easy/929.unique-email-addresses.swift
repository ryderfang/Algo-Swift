/*
 * @lc app=leetcode id=929 lang=swift
 *
 * [929] Unique Email Addresses
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func numUniqueEmails(_ emails: [String]) -> Int {
        var ans = Set<String>()
        for email in emails {
            var addr = ""
            var hasPlus = false, hasAt = false
            for ch in email {
                if ch == "+" {
                    hasPlus = true
                } else if ch == "." {
                    if hasAt {
                        addr.append(ch)
                    } else {
                        continue
                    }
                } else if ch == "@" {
                    hasAt = true
                    addr.append(ch)
                } else {
                    if !hasPlus || hasAt {
                        addr.append(ch)
                    }
                }
            }
            ans.insert(addr)
        }
        return ans.count
    }
}
// @lc code=end

