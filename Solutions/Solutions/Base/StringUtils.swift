//
//  StringUtils.swift
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
        switch (self) {
        case "a"..."z":
            fallthrough
        case "A"..."Z":
            return true
        default:
            return false
        }
    }
    
    // 只判断阿拉伯数字 [0-9] -> AlphaValue [48...57]
    // isNumber 还包括 ㊈ 𝟠 这种 unicode 字符
    public func isDigit() -> Bool {
        switch (self) {
        case "0"..."9":
            return true
        default:
            return false
        }
    }
}
