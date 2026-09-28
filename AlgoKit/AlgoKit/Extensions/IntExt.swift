//
//  IntExt.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

// Int == Int64
// Int32.max -> 2**31-1 = 2147483647
// Int32.min -> -2**31 = -2147483648
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
//        return String(self).first
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
private extension Array<Int> {
    func bitsToInt() -> Int {
        var iVal = 0
        for b in self {
            iVal = iVal * 2 + b
        }
        return iVal
    }
}

extension Int {
    public func toBinary(bitWidth: Int = 32) -> String {
        guard self != 0 else { return "0" }
        var bits = ""
        var n = self
        while n != 0 && bits.count < bitWidth {
            bits = String(n & 1) + bits
            n >>= 1
        }
        return bits
    }

    // convert dividend to binary, high to low
    public func toBits() -> [Int] {
        var bits = [Int]()
        var n = self
        while n != 0 {
            bits = [n & 1] + bits
            n >>= 1
        }
        return bits
    }

    // lc405
    public func toHex(bitWidth: Int = 32, uppercase: Bool = false) -> String {
        guard self != 0 else { return "0" }
        // only valid for positive
        if self > 0 {
            return String(self, radix: 16, uppercase: uppercase)
        }
        var hex = ""
        var n = self
        while n != 0 && hex.count < bitWidth / 4 {
            let digit = n & 15
            var char = String(digit)
            if digit > 9 {
                let ascii: UInt32 = (uppercase ? UnicodeScalar("A") : UnicodeScalar("a")).value + UInt32(digit) - 10
                char = String(UnicodeScalar(ascii)!)
            }
            hex = char + hex
            n >>= 4
        }
        return hex
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

    func isPowerOfTwo() -> Bool {
        let n = self
        guard n > 0 else { return false }
        return (n & (n - 1)) == 0
    }

    func isPowerOfThree() -> Bool {
        let n = self
        guard n > 0 else { return false }
        // calculated by python:
        // list(map(lambda x: 3 ** x, list(range(0,20))))
        // 3^20 = 3486784401 > 2147483647 = 2^31 - 1
        let p = [1, 3, 9, 27, 81, 243, 729, 2187, 6561, 19683, 59049, 177147, 531441, 1594323, 4782969, 14348907, 43046721, 129140163, 387420489, 1162261467]
        return p.contains(n)
    }

    // 4^n = 2^(2*n)
    // 4^n = 3 * (4^n-1 + 4^n-2 + ... + 4 + 1)
    func isPowerOfFour() -> Bool {
        let n = self
        return n > 0 && (n & (n - 1) == 0) && (n - 1) % 3 == 0
    }
}

// 32 位随机数
// -> Int.random(in: 0..<n)
// -> arc4random() % upper_bound
// -> arc4random_uniform(upper_bound)

// 64 位随机数
func arc4random<T: ExpressibleByIntegerLiteral> (type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, MemoryLayout<T>.size)
    return r
}

extension UInt64 {
    static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
        var m: UInt64
        let u = upper - lower
        var r = arc4random(type: UInt64.self)
        if u > UInt64(Int64.max) {
            m = 1 + ~u
        } else {
            m = ((max - (u * 2)) + 1) % u
        }
        while r < m {
            r = arc4random(type: UInt64.self)
        }
        return (r % u) + lower
    }
}
