/*
 * @lc app=leetcode id=372 lang=swift
 *
 * [372] Super Pow
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Better solution: recursion
    func superPow(_ a: Int, _ b: [Int]) -> Int {
        if b.count == 0 { return 1 }
        func powerWithMode(_ a: Int, _ b: Int, _ mod: Int = 1337) -> Int {
            if b == 0 { return 1 }
            if b == 1 { return a % mod }
            
            let power = powerWithMode(a, b / 2, mod)
            let powerWithMode = (power * power) % mod
            return b % 2 == 0 ? powerWithMode : (powerWithMode * a) % mod
            
        }
        
        var b = b
        let last = b.removeLast()
        return powerWithMode(a, last) * powerWithMode(superPow(a, b), 10) % 1337
    }


    // Fermat's little theorem (费马小定理)
    // if p is a prime, a^p ≡ a (mod p)
    // if (a, n) = 1, a^(p-1) ≡ 1 (mod p)

    // Euler's theorem (欧拉定理)
    // if (a, n) = 1, a^phi(n) ≡ 1 (mod n) 
    // phi(n) = n - 1, if n is prime -> 费马小定理
    func superPow1(_ a: Int, _ b: [Int]) -> Int {
        // 1337 = 7 * 191
        let n = 1337
        guard a % n != 0 else { return 0 }
        if a % 7 == 0 {
            // (7 * k) ^ b = [(7 ^ (b - 1)) * (k ^ b)] * 7
            return ((euler(7, b.minus1(), 190, 191) * euler(a / 7, b, 190, 191)) * 7) % n
        } else if a % 191 == 0 {
            return ((euler(191, b.minus1(), 6, 7) * euler(a / 191, b, 6, 7)) * 191) % n
        } else {
            // phi(n) - [1, n] 中与 n 互质的数的个数
            // 1140
            var phi = n - 1
            for i in 1..<n {
                if i % 7 == 0 || i % 191 == 0 {
                    phi -= 1
                }
            }
            return euler(a, b, phi, n)
        }
    }

    func euler(_ a: Int, _ b: [Int], _ phi: Int, _ n: Int) -> Int {
        var tens = 1
        var remainder = 0
        for x in b.reversed() {
            remainder = (remainder + (x * tens) % phi) % phi
            tens = (tens * 10) % phi
        }
        var ans = 1
        let a = a % n
        for _ in 0..<remainder {
            ans = (ans * a) % n
        }
        return ans
    }
}

fileprivate extension Array where Element == Int {
    func minus1() -> [Int] {
        var ans = self
        var i = self.count - 1
        while self[i] == 0 {
            i -= 1
        }
        ans[i] -= 1
        for j in i+1..<self.count {
            ans[j] = 9
        }
        return ans
    }
}

// @lc code=end
