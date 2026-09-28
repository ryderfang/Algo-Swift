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
    public static func lcm(_ a: Int, _ b: Int) -> Int {
        return (a * b) / gcd(a, b)
    }
    
    // 最大公约数
    public static func gcd(_ a: Int, _ b: Int) -> Int {
        if b == 0 {
            return a
        }
        return gcd(b, a % b)
    }
    
    // 扩展的欧几里德算法 (最大公约数算法)
    // 返回 gcd(a, b) 的同时，获取 a * x + b * y = gcd(a, b) 的唯一解
    public static func exgcd(_ a: Int, _ b: Int) -> (Int, Int, Int) {
        if b == 0 {
            return (a, 1, 0)
        }
        let (d, x, y) = exgcd(b, a % b)
        return (d, y, x - (a / b) * y)
    }
    
    // 中国剩余定理 https://oi-wiki.org/math/number-theory/crt/
    // k is length of a & r
    // x = a[i] (mod r[i])
    public static func CRT(k: Int, a: Array<Int>, r: Array<Int>) -> Int {
        // 计算所有模数的积
        let n = r.reduce(1, { $0 * $1 })
        var ans = 0
        for i in 0..<k {
            let m = n / r[i]
            // b * m mod r[i] = 1
            let (_, b, _) = exgcd(m, r[i])
            ans = (ans + a[i] * m * b % n) % n
        }
        return (ans % n + n) % n
    }
}
