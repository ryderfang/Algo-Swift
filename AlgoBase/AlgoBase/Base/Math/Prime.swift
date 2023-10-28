//
//  Prime.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/13.
//

import Foundation

/*
 Primes -
  > below 100 (25 个)
  > below 1000 (168 个):
 [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997]
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
