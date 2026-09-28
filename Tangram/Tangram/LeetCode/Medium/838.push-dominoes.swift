/*
 * @lc app=leetcode id=838 lang=swift
 *
 * [838] Push Dominoes
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func pushDominoes(_ dominoes: String) -> String {
        func _stringToArray(_ str: [Character]) -> [Int] {
            return str.map {
                switch $0 {
                case "L": return -1
                case ".": return 0
                default: return 1
                }
            }
        }
        func _arrayToString(_ arr: [Int]) -> [Character] {
            return arr.map {
                if $0 < 0 { return "L" }
                if $0 == 0 { return "." }
                return "R"
            }
        }
        let n = dominoes.count
        var domino = Array(dominoes)
        while true {
            var tmp = _stringToArray(domino)
            for i in 0..<n {
                if domino[i] == "L" && i > 0 && domino[i-1] == "." {
                    tmp[i-1] -= 1
                } else if domino[i] == "R" && i < n - 1 && domino[i+1] == "." {
                    tmp[i+1] += 1
                }
            }
            let next = _arrayToString(tmp)
            if next == domino {
                break
            }
            domino = next
        }
        return String(domino)
    }
}
// @lc code=end

