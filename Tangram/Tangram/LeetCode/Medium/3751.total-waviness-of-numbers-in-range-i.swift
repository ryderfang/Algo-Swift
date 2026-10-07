/*
 * @lc app=leetcode id=3751 lang=swift
 *
 * [3751] Total Waviness of Numbers in Range I
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    // dp[i] = dp[i/10] + (isWave of last 3 numbers)
    // sum[num1: num2] = preSum[num2] - preSum[num1]
    func totalWaviness(_ num1: Int, _ num2: Int) -> Int {
        let maxn = Int(1e5 + 1)
        var dp = [Int](repeating: 0, count: maxn)
        var preSum = [Int](repeating: 0, count: maxn)
        for i in 100..<maxn {
            let r = i % 10
            let m = (i / 10) % 10
            let l = (i / 100) % 10
            let isWave = (m > max(r, l) || m < min(r, l))
            dp[i] = dp[i/10] + (isWave ? 1 : 0)
            preSum[i] = preSum[i-1] + dp[i]
        }
        return preSum[num2] - preSum[num1-1]
    }
    
    func totalWaviness1(_ num1: Int, _ num2: Int) -> Int {
        func _addOne(_ digits: inout [Int]) {
            var carry = 1
            for i in 0..<digits.count {
                let tmp = digits[i] + carry
                digits[i] = (digits[i] + carry) % 10
                carry = tmp / 10
                if carry == 0 { break }
            }
            if carry != 0 {
                digits.append(carry)
            }
        }
        
        var mem = [Int](repeating: 0, count: Int(1e5 + 1))
        var digits = [0, 0, 1]
        for i in 101..<Int(1e5 + 1) {
            _addOne(&digits)
            var ret = 0
            for j in 1..<digits.count-1 {
                if digits[j] > digits[j-1] && digits[j] > digits[j+1] {
                    ret += 1
                }
                if digits[j] < digits[j-1] && digits[j] < digits[j+1] {
                    ret += 1
                }
            }
            mem[i] = ret
        }
        var ans = 0
        for i in num1...num2 {
            ans += mem[i]
        }
        return ans
    }
}
// @lc code=end
