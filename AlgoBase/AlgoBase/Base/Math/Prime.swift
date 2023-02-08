//
//  Prime.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/13.
//

import Foundation

/* primes below 100:
 [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
**/
public class Prime {
    public static func isPrime(_ n: Int) -> Bool {
        guard n > 1 else { return false }
        guard n > 4 else { return true }
        let t = Int(sqrt(Double(n)))
        for i in 2...t {
            guard n % i != 0 else { return false }
        }
        return true
    }

    // 素材筛 (欧拉筛)
    public static func getPrimes(_ n: Int) -> [Int] {
        var p = [Bool](repeating: true, count: n)
        (p[0], p[1]) = (false, false)
        var plist = [Int]()
        for i in 2..<n {
            if p[i] {
                plist.append(i)
            }
            for x in plist {
                guard x * i < n else { break }
                p[x * i] = false
                // 避免重复，每个合数只需要被最小的素数筛过
                if i % x == 0 {
                    break
                }
            }
        }
        return plist
    }

    // 素材筛 (The Sieve of Eratosthenes, 埃氏筛)
    public static func getPrimes2(_ n: Int) -> [Int] {
        var p = [Bool](repeating: true, count: n)
        (p[0], p[1]) = (false, false)
        var plist = [Int]()
        for i in 2..<n {
            if p[i] {
                plist.append(i)
                // [i * i, n) 比 [2 * i, n) 效率稍高
                for j in stride(from: i * i, to: n, by: i) {
                    p[j] = false
                }
            }
        }
        return plist
    }

}
