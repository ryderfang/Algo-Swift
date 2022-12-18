//
//  Prime.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/13.
//

import Foundation

class Prime {
    static func isPrime(_ n: Int) -> Bool {
        guard n > 1 else { return false }
        guard n > 4 else { return true }
        let t = Int(sqrt(Double(n)))
        for i in 2...t {
            guard n % i != 0 else { return false }
        }
        return true
    }

    // 素材筛 (欧拉筛)
    static func getPrimes(_ Limit: Int) -> [Int] {
        var isPrime = [Bool](repeating: true, count: Limit)
        (isPrime[0], isPrime[1]) = (false, false)
        var plist = [Int]()
        for i in 2..<Limit {
            if isPrime[i] {
                plist.append(i)
            }
            for p in plist {
                guard p * i < Limit else { break }
                isPrime[p * i] = false
                // 避免重复，每个合数只需要被最小的素数筛过
                if i % p == 0 {
                    break
                }
            }
        }
        return plist
    }

    // 素材筛 (The Sieve of Eratosthenes, 埃氏筛)
    static func getPrimes2(_ Limit: Int) -> [Int] {
        var isPrime = [Bool](repeating: true, count: Limit)
        (isPrime[0], isPrime[1]) = (false, false)
        var plist = [Int]()
        for i in 2..<Limit {
            if isPrime[i] {
                plist.append(i)
                // [i * i, n) 比 [2 * i, n) 效率稍高
                for j in stride(from: i * i, to: Limit, by: i) {
                    isPrime[j] = false
                }
            }
        }
        return plist
    }

}
