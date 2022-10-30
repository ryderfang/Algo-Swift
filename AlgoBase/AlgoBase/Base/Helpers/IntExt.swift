//
//  IntExt.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

extension Int {
    public func isPrime() -> Bool {
        if self < 2 {
            return false
        }
        let m = Int(floor(sqrt(Double(self)) + 0.5))
        // not use 2...m, may crash when m < 2
        for i in stride(from: 2, through: m, by: 1) {
            if self % i == 0 {
                return false
            }
        }
        return true
    }

    // 0-9
    // Character(UnicodeScalar(self + 48)!)
    public func digitChar() -> Character? {
        guard (0...9).contains(self) else {
            return nil
        }
        // 48
        let zero = Int(("0" as UnicodeScalar).value)
        return Character(UnicodeScalar(self + zero)!)
    }

    // [A...Z] -> [65...90]
    // [a...z] -> [97...122]
    // Int(("A" as UnicodeScalar).value) -> 65
    // Int(("a" as UnicodeScalar).value) -> 97
    public func alphaChar() -> Character? {
        guard (65...90).contains(self) || (97...122).contains(self) else {
            return nil
        }
        return Character(UnicodeScalar(self)!)
    }
}

// MARK: Binary
extension Int {
    public func binaryStr() -> String {
        return String(self, radix: 2)
    }

    // the number of '1' bits self has
    public func hammingWeight() -> Int {
        var n = self, result = 0
        while n != 0 {
            result += 1
            // https://stackoverflow.com/questions/4678333/n-n-1-what-does-this-expression-do
            n &= n - 1
        }
        return result

        // or
//        return self.nonzeroBitCount
    }

    public func isPowOfTwo() -> Bool {
        let n = self
        return n > 0 && (n & (n - 1)) == 0
    }
}

extension String {
    public func binaryToInt() -> Int {
        return strtol(self, nil, 2)
    }
}


// MARK: BigInt
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
