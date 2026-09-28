/*
 * @lc app=leetcode id=394 lang=swift
 *
 * [394] Decode String
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution
    func decodeString(_ s: String) -> String {
        var intStack = [Int](), strStack = [String](), currentNum = Int(), currentString = String()
        for char in s {
            if char == "[" {
                strStack.append(currentString)
                intStack.append(currentNum)
                currentString = ""
                currentNum = 0
            } else if char == "]" {
                let num = intStack.removeLast()
                let prevString = strStack.removeLast()
                currentString = prevString + String(repeating: currentString, count: num)
            } else if let charNum = Int(String(char)) {
                currentNum = currentNum * 10 + charNum
            } else {
                currentString.append(String(char))
            }
        }
        return currentString
    }

    func decodeString1(_ s: String) -> String {
        let s = Array(s)
        func _decode(_ chs: [Character]) -> String {
            let n = chs.count
            var nums = [Int]()
            var words = [[Character]]()
            var tmp_num = [Character]()
            var tmp_word = [Character]()
            words.append([])
            for i in 0..<n {
                if ("0"..."9").contains(chs[i]) {
                    tmp_num.append(chs[i])
                } else if chs[i] == "[" {
                    nums.append(Int(String(tmp_num))!)
                    tmp_num.removeAll()
                    // save
                    if tmp_word.count > 0 {
                        var last_word = words.removeLast()
                        last_word.append(contentsOf: tmp_word)
                        words.append(last_word)
                    }
                    words.append([])
                    tmp_word.removeAll()
                } else if chs[i] == "]" {
                    // save
                    if tmp_word.count > 0 {
                        var last_word = words.removeLast()
                        last_word.append(contentsOf: tmp_word)
                        words.append(last_word)
                    }

                    let cur_count = nums.removeLast()
                    let cur_word = words.removeLast()
                    var last_word = words.removeLast()
                    for _ in 0..<cur_count {
                        last_word.append(contentsOf: cur_word)
                    }
                    words.append(last_word)
                    tmp_word.removeAll()
                } else {
                    // letters
                    tmp_word.append(chs[i])
                }
            }
            if tmp_word.count > 0 {
                var last_word = words.removeLast()
                last_word.append(contentsOf: tmp_word)
                words.append(last_word)
            }
            return String(words[0])
        }
        return _decode(s)
    }
}
// @lc code=end
