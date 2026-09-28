/*
 * @lc app=leetcode id=71 lang=swift
 *
 * [71] Simplify Path
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func simplifyPath(_ path: String) -> String {
        var folders = [String]()
        let p: [Character] = Array(path)
        let n = p.count
        var i = 0, start = true
        var name = [Character]()
        while i <= n {
            if start {
                if i < n && p[i] != Character("/") {
                    start = false
                    name.append(p[i])
                }
            } else {
                if i < n && p[i] != Character("/") {
                    name.append(p[i])
                } else {
                    let tmpName = String(name)
                    if tmpName == ".." {
                        // removeLast() will crash if empty
                        _ = folders.popLast()
                    } else if tmpName != "." {
                        folders.append(tmpName)
                    }
                    name.removeAll()
                    start = true
                }
            }
            i += 1
        }
        return "/" + folders.joined(separator: "/")
    }
}
// @lc code=end

