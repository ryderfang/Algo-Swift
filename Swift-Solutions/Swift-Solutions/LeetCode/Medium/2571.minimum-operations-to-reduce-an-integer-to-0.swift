/*
 * @lc app=leetcode id=2571 lang=swift
 *
 * [2571] Minimum Operations to Reduce an Integer to 0
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Better solution
    func minOperations(_ n: Int) -> Int {
        var t = n
        var op = 0
        while t > 0 {
            // 000..xx11
            if (t & 3) == 3 {
                t += 1
                op += 1
            } else {
                // 00xx..x00 /x10 / x01
                op += (t & 1)
                t >>= 1
            }
        }
        return op
    }
    
    // Better solution1
    func minOperations1(_ n: Int) -> Int {
        var pows = [1]
        while let last = pows.last, last <= n {
            pows.append(last * 2)
        }
        var t = n, op = 0
        while t > 0 {
            let closest = pows.min(by: { abs(t - $0) < abs(t - $1) })!
            t = abs(t - closest)
            op += 1
        }
        return op
    }
    
    // Trick solution
    func minOperations2(_ n: Int) -> Int {
        return (n ^ (n * 3)).nonzeroBitCount
    }
    
     
    // n <- [1, 10^5]
    func minOperations3(_ n: Int) -> Int {
        var dp = [Int](repeating: -1, count: n * 2)
        dp[0] = 0
        func _solve(_ bits: [Int]) -> Int {
            let n = bits.bitsToInt()
//            print(bits, n)
            guard dp[n] < 0 else { return dp[n] }
            if n.isPowerOfTwo() {
                dp[n] = 1
                return 1
            }
            // 0011100...0110000
            // find two group of 1's ~> 00[a2,b2]0000[a1,b1]00
            var (a1, b1) = (-1, -1)
            var (a2, b2) = (-1, -1)
            // [a1...b1] = [11...11]
            b1 = bits.count - 1
            while b1 >= 0 && bits[b1] == 0 { b1 -= 1 }
            a1 = b1
            while a1 >= 0 && bits[a1] == 1 { a1 -= 1 }
            // [a2...b2] = [11...11]
            b2 = a1 // bits[b2] == 0 || b2 == -1
            a1 += 1
            while b2 >= 0 && bits[b2] == 0 { b2 -= 1 }
            if b2 < 0 {
                // only one group of 1's
                // a. 1111 -> 10000 -> 0
                // b. 1111 -> 1110 -> 1100 -> 1000 -> 0000
                dp[n] = min(b1 - a1 + 1, 2)
                return dp[n]
            }
            a2 = b2
            while a2 >= 0 && bits[a2] == 1 { a2 -= 1 }
            a2 += 1
            // two options
            // 1. [a1, b1] -> [0000] // 2
            // 2. [b2+1, a1-1] -> [1111] // a1 - b2 -1
            var op1 = bits
            for i in a1...b1 { op1[i] = 0 }
            var op2 = bits
            for i in b2+1...a1-1 { op2[i] = 1 }
            dp[n] = min(min(b1 - a1 + 1, 2) + _solve(op1),
                        a1 - b2 - 1 + _solve(op2))
            return dp[n]
        }
        return _solve(n.toBits())
    }
}

private extension Int {
    func toBits() -> [Int] {
        var bits = [Int]()
        var n = self
        while n != 0 {
            bits = [n & 1] + bits
            n >>= 1
        }
        return bits
    }
    
    func isPowerOfTwo() -> Bool {
        let n = self
        guard n > 0 else { return false }
        return (n & (n - 1)) == 0
    }
}
    
private extension Array<Int> {
    func bitsToInt() -> Int {
        var iVal = 0
        for b in self {
            iVal = iVal * 2 + b
        }
        return iVal
    }
}

// @lc code=end

