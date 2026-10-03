/*
 * @lc app=leetcode id=1614 lang=swift
 *
 * [1614] Maximum Nesting Depth of the Parentheses
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    // `s` is a valid parentheses string (VPS), so "((" or "))" is not valid test case.
    func maxDepth(_ s: String) -> Int {
        let s = s.map { String($0) }
        var depth = 0
        var ans = 0
        for str in s {
            if str == "(" {
                depth += 1
            } else if str == ")" {
                depth -= 1
            }
            if depth > ans {
                ans = depth
            }
        }
        return ans
    }
    
    func maxDepth1(_ s: String) -> Int {
        let s = s.map { String($0) }
        guard s.count > 1 else { return 0 }
        let cnt = s.count
        var ans = 0, tmp = 0
        var left = 0
        for i in 0..<cnt {
            if s[i] == "(" {
                // assume the left brackets will pair
                if tmp > 0 {
                    tmp += left
                    ans = max(ans, tmp)
                }
                
                left += 1
                tmp = 0
            } else if s[i] == ")" {
                if left > 0 {
                    tmp += 1
                    left -= 1
                }
            }
        }
        if tmp > 0 {
            tmp += left
            ans = max(ans, tmp)
        }
        if ans >= left {
            // remove un-paired
            ans -= left
        }
        return ans
    }
}
// @lc code=end
