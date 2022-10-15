//
//  Basic.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

// 来自于 <算法竞赛入门经典> 的一些例题 & 习题的 Swift 实现

import Foundation
import AVFoundation

public class Primer {
    class func p1_2() {
        print(String(format: "%.2f", 8.0 / 5.0))
    }
    class func p1_3() {
        print(String(format: "%.8lf", 1 + 2 * sqrt(3) / (5 - 0.1)))
    }
    class func p1_4() {
        let a = Int(readLine()!) ?? 0
        let b = Int(readLine()!) ?? 0
        print(a + b)
    }
    class func p1_5() {
        let pi = 4.0 * atan(1.0);
        let input = readLine()!.components(separatedBy: " ").map{ Double($0)! }
        let r = input[0]
        let h = input[1]
        let s1 = pi * r * r
        let s2 = 2 * pi * r * h
        let s = 2 * s1 + s2
        print(String(format: "Area: %.3lf", s))
    }
    class func p1_6() {
        let n = Int(readLine()!)!
        print(String(format: "%d%d%d\n", n % 10, (n / 10) % 10, n / 100))
        let m = (n % 10) * 100 + (n/10%10) * 10 + n / 100
        print(String(format: "%03d", m))
        // 四舍五入
//        let n = Double(readLine()!)!
//        print(Int((n + 0.5)))
    }
    class func p1_7() {
        let input = readLine()!.components(separatedBy: " ").map{ Int($0)! }
        var a, b : Int
        (a, b) = (input[0], input[1])
        // swap1 -> recommend
        (a, b) = (b, a)
        // swap2
//        let t = a
//        a = b
//        b = t
        // swap3
//        a = a + b
//        b = a - b
//        a = a - b
        // swap4
//        a ^= b
//        b ^= a
//        a ^= b
        print(a, b)
    }
    class func p2_2() {
        // 7744 problem
        var n: Int
        var m: Double
        // [1,9]
        for i in (1...9) {
            // [0, 10)
            for j in (0..<10) {
                n = i * 1100 + j * 11
                m = sqrt(Double(n))
                if (floor(m + 0.5) == m) {
                    print(n)
                }
            }
        }
    }
    class func p2_3() {
        var n, hi, lo: Int
        for x in (1...) {
            n = x * x
            if n < 1000 {
                continue
            }
            if n > 9999 {
                break
            }
            hi = n / 100
            lo = n % 100
            if (hi / 10 == hi % 10 && lo / 10 == lo % 10) {
                print(n)
            }
        }
    }
    class func p2_4() {
        // 3n + 1 problem
        var n = Int(readLine()!)!
        var count = 0
        while n > 1 {
            if n % 2 == 1 {
                n = (n * 3 + 1) / 2
            } else {
                n /= 2
            }
            print(n)
            count += 1
        }
        print(count)
    }
    
    class func p2_6() {
        TICK()
        
        let n = Int(readLine()!)!
        var fact = 1
        let MOD = 1000000
        for i in 2...n {
           fact = (fact * i % MOD)
        }
        print(fact)
        
        TOCK()
    }
    static func prac2_3() {
        // 中国剩余定理
        let lines = READNUMS()
        for nums in lines {
            print(nums)
            let ans = NumberTheory.CRT(k: nums.count, a: nums, r: [3, 5, 7])
            print(ans)
        }
    }
    static func p3_2() {
        // 蛇形填数
        let n = 4
        var a = Array(repeating: Array(repeating: 0, count: n), count: n)
        var (x, y) = (0, n - 1)
        a[x][y] = 1
        var count = 1
        while count < n * n {
            while x + 1 < n && a[x+1][y] == 0 {
                x += 1
                count += 1
                a[x][y] = count
            }
            while y - 1 >= 0 && a[x][y-1] == 0 {
                y -= 1
                count += 1
                a[x][y] = count
            }
            while x - 1 >= 0 && a[x-1][y] == 0 {
                x -= 1
                count += 1
                a[x][y] = count
            }
            while y + 1 < n && a[x][y+1] == 0 {
                y += 1
                count += 1
                a[x][y] = count
            }
        }
//        print(a)
        // 圈打矩阵
        let nums = READNUMS()
        var (i, j) = (0, 0)
        let (r, c) = (nums.count, nums[0].count)
        var flag = Array(repeating: Array(repeating: 0, count: c), count: r)
        var tot = 1
        flag[0][0] = 1
        var ans = "\(nums[i][j])" + ", "
        while tot < r * c {
            while j + 1 < c && flag[i][j+1] == 0 {
                j += 1
                tot += 1
                flag[i][j] = 1
                ans += "\(nums[i][j])" + ", "
            }
            while i + 1 < r && flag[i+1][j] == 0 {
                i += 1
                tot += 1
                flag[i][j] = 1
                ans += "\(nums[i][j])" + ", "
            }
            while j - 1 >= 0 &&  flag[i][j-1] == 0 {
                j -= 1
                tot += 1
                flag[i][j] = 1
                ans += "\(nums[i][j])" + ", "
            }
            while i - 1 >= 0 &&  flag[i-1][j] == 0 {
                i -= 1
                tot += 1
                flag[i][j] = 1
                ans += "\(nums[i][j])" + ", "
            }
        }
        print(ans)
    }
    static func p3_5() {
        let lines = READFILE()
        for ln in lines {
            let chars = Array(ln)
            let n = chars.count
            // 保存预处理之后的序号与原串中序号的对应关系
            var p = Array(repeating: 0, count: n)
            var alphas = [Character]()
            for (i, ch) in chars.enumerated() {
                if ch.isAlpha() {
                    alphas.append(ch)
                    p[alphas.count-1] = i
                }
            }
            alphas = alphas.map({
                Character($0.uppercased())
            })
            
            print(alphas)
            let sz = alphas.count
            var max = 0
            var (x, y) = (0, 0)
            for i in 0..<sz {
                // 奇数串
                for j in 0..<sz-i {
                    if i < j || alphas[i-j] != alphas[i+j] {
                        break
                    }
                    if (j * 2 + 1 > max) {
                        max = j * 2 + 1
                        x = p[i-j]
                        y = p[i+j]
                    }
                }
                // 偶数串
                for j in 0..<sz-i-1 {
                    if i < j || alphas[i-j] != alphas[i+j+1] {
                        break
                    }
                    if (j * 2 + 2 > max) {
                        max = j * 2 + 2
                        x = p[i-j]
                        y = p[i+j+1]
                    }
                }
            }
            print(String(chars[x...y]))
        }
    }
    public static func p4_3() {
        let lines = READNUMS()
        for ln in lines {
            let x = ln[0]
            print(x.isPrime())
        }
    }
    public static func p5_2() {
        var a = BigInt(i: 12345)
        let b = BigInt(str: "9876587882321")
        a.output()
        b.output()
        print(a < b)
        a = BigInt(str: "9877587882321")
        print(a < b)
        a += b
        a.output()
    }
}
