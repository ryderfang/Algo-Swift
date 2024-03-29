//
//  BigInt.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/25.
//

import Foundation

public class BigInt {
    let maxSize : Int = 1000
    var negative : Bool = false
    // 逆序存储
    var s : Array<Int>
    var size : Int {
        get {
            s.count
        }
    }
    init() {
        self.s = [Int]()
    }
    convenience init(i: Int) {
        self.init()
        var temp = i
        if i < 0 {
            temp = -i
            self.negative = true
        }
        while temp > 0 {
            self.s.append(temp % 10)
            temp /= 10
        }
    }
    convenience init(str: String) {
        self.init()
        if str.count == 0 {
            return
        }
        var temp = Array(str)
        if temp[0] == "-" {
            temp.remove(at: 0)
            self.negative = true
        }
        for ch in temp.reversed() {
            self.s.append(ch.wholeNumberValue!)
        }
    }

    func output() {
        Swift.print((self.negative ? "-" : "") + Array(self.s.reversed()).map{ String($0) }.joined())
    }

    // 下标运算符
    private subscript(index: Int) -> Int {
        get {
            guard index < size else {
                return -1
            }
            return s[index]
        }
        set {
            // extend array
            if index >= size {
                s.append(contentsOf: Array(repeating: 0, count: index + 1 - s.endIndex))
            }
            s[index] = newValue
        }
    }

    static prefix func -(a: inout BigInt) {
        a.negative = true
    }

    static func +(a: BigInt, b: BigInt) -> BigInt {
        let ans = BigInt(i: 0)
        var (i, carry) = (0, 0)
        let size_a = a.size
        let size_b = b.size
        while carry > 0 || i < max(size_a, size_b) {
            var sum = carry
            if i < size_a {
                sum += a[i]
            }
            if i < size_b {
                sum += b[i]
            }
            // auto extend
            ans[i] = sum % 10
            carry = sum / 10
            i += 1
        }
        return ans
    }

    static func +=(a: inout BigInt, b: BigInt) {
        a = a + b
    }

    static func <(lhs: BigInt, rhs: BigInt) -> Bool {
        if lhs.size != rhs.size {
            return lhs.size < rhs.size
        }
        for i in (0..<lhs.size).reversed() {
            if lhs[i] != rhs[i] {
                return lhs[i] < rhs[i]
            }
        }
        return false
    }
}
