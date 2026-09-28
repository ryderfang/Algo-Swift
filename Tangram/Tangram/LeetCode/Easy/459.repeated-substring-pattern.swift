/*
 * @lc app=leetcode id=459 lang=swift
 *
 * [459] Repeated Substring Pattern
 */

// @lc code=start
extension Solution {
    // 题解比较妙：return (s + s)[1..<2*n-1].contains(s)
    func repeatedSubstringPattern(_ s: String) -> Bool {
        let n = s.count
        guard n > 1 else { return false }
        let arr: [Character] = Array(s)
        if n == 2 {
            return arr[0] == arr[1]
        } else if n == 3 {
            return arr[0] == arr[1] && arr[1] == arr[2]
        }
        // check 1 len sub for TLE
        var check = true
        for i in 1..<n {
            if arr[i] != arr[i-1] {
                check = false
                break
            }
        }
        if check {
            return true
        }

        for i in 2...n/2 {
            guard n % i == 0 else { continue }
            var check = true
            let subLength = n / i
            for j in stride(from: subLength, to: n, by: subLength) {
                let sub1 = arr[j-subLength..<j]
                let sub2 = arr[j..<j+subLength]
                if sub1 != sub2 {
                    check = false
                    break
                }
            }
            if check {
                print(i, String(arr[0..<subLength]))
                return true
            }
        }
        return false
    }
}
// @lc code=end

