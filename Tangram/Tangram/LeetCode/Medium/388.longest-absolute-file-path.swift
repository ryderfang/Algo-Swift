/*
 * @lc app=leetcode id=388 lang=swift
 *
 * [388] Longest Absolute File Path
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func lengthLongestPath(_ input: String) -> Int {
        var stack = [(String, Int)]()
        let input = [Character](input)
        let n = input.count
        var i = 0
        var tmp = [Character]()
        var tab = 0
        var ans = 0
        while i < n {
            var isFile = false
            while i < n && input[i] != "\n" {
                tmp.append(input[i])
                if input[i] == "." {
                    isFile = true
                }
                i += 1
            }
            while !stack.isEmpty {
                if let top = stack.last, top.1 >= tab {
                    stack.removeLast()
                } else {
                    break
                }
            }
            if !isFile {
                stack.append((String(tmp), tab))
            } else {
                let path = (stack.map { $0.0 } + [String(tmp)]).joined(separator: "/")
                print(path)
                ans = max(ans, path.count)
            }
            tmp.removeAll()

            if i < n {
                i += 1
                tab = 0
                while i < n && input[i] == "\t" {
                    i += 1
                    tab += 1
                }
            }
        }
        return ans
    }
}
// @lc code=end

