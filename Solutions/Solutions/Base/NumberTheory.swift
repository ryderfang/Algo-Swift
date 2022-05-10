//
//  NumberTheory.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/2.
//

import Foundation

class NumberTheory {
    // 最小公倍数
    // gcd(a, b) * lcm(a, b) = a * b
    static public func lcm(a: Int, b: Int) -> Int {
        return (a * b) / self.gcd(a: a, b: b)
    }
    
    // 最大公约数
    static public func gcd(a: Int, b: Int) -> Int {
        if b == 0 {
            return a
        }
        return gcd(a: b, b: a % b)
    }
    
    // 扩展的欧几里德算法 (最大公约数算法)
    // 返回 gcd(a, b) 的同时，获取 a * x + b * y = gcd(a, b) 的唯一解
    static public func exgcd(a: Int, b: Int) -> (Int, Int, Int) {
        if b == 0 {
            return (a, 1, 0)
        }
        let (d, x, y) = exgcd(a: b, b: a % b)
        return (d, y, x - (a / b) * y)
    }
    
    // 中国剩余定理 https://oi-wiki.org/math/number-theory/crt/
    // k is length of a & r
    // x = a[i] (mod r[i])
    static public func CRT(k: Int, a: Array<Int>, r: Array<Int>) -> Int {
        // 计算所有模数的积
        let n = r.reduce(1, { $0 * $1 })
        var ans = 0
        for i in 0..<k {
            let m = n / r[i]
            // b * m mod r[i] = 1
            let (_, b, _) = exgcd(a: m, b: r[i])
            ans = (ans + a[i] * m * b % n) % n
        }
        return (ans % n + n) % n
    }
}
