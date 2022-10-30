//
//  StringExt.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/3.
//

import Foundation

extension Character {
    // alphaValue:
    // [a...z] -> [97...122]
    // [A...Z] -> [65...90]
    // 这里只判断英文字符 [a-zA-z]
    // isLetter 对于非英文字母也返回 true
    public func isAlpha() -> Bool {
        return ("a"..."z").contains(self) || ("A"..."Z").contains(self)
    }
    
    // 只判断阿拉伯数字 [0-9] -> AlphaValue [48...57]
    // isNumber 还包括 ㊈ 𝟠 这种 unicode 字符
    public func isDigit() -> Bool {
        return ("0"..."9").contains(self)
    }

    // ④ -> 4
    // 百 -> 100
    public func wholeInt() -> Int? {
        guard let intValue = self.wholeNumberValue else {
            return nil
        }
        return intValue
    }

    // "0" -> 0
    public func toInt() -> Int? {
        guard let intValue = Int(String(self)) else {
            return nil
        }
        return intValue
    }
}

extension String {
    public func intArray() -> [Int?] {
        return self.map { Int(String($0)) }
    }

    public static func charArray() -> [String] {
        return (UnicodeScalar("A").value...UnicodeScalar("Z").value).map { String(UnicodeScalar($0)!) }
    }

    public mutating func zfill(_ width: Int) {
        guard self.count < width else { return }
        self.insert(contentsOf: [Character](repeating: "0", count: width - self.count), at: self.startIndex)
    }

    public func binaryToInt() -> Int {
        return strtol(self, nil, 2)
    }
}

fileprivate extension String {
    // 扩展下标方法
    subscript (i: Int) -> Character {
            return self[self.index(self.startIndex, offsetBy: i)]
    }

    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }

    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start..<end])
    }

    subscript (r: ClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return String(self[start...end])
    }
}
