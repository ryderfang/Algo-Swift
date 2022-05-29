//
//  bm83.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/18.
//

import Foundation

extension Solution {
    /**
     * 代码中的类名、方法名、参数名已经指定，请勿修改，直接返回方法规定的值即可
     *
     * @param s string字符串
     * @param n int整型
     * @return string字符串
     */
    func trans ( _ s: String,  _ n: Int) -> String {
        var words : Array<String> = s.components(separatedBy: " ")
        words = words.map({ (w: String) -> String in
            var ans : Array<String> = w.map({ String($0) })
            for i in 0..<ans.count {
                if Character(ans[i]).isLowercase {
                    ans[i] = ans[i].uppercased()
                } else if Character(ans[i]).isUppercase {
                    ans[i] = ans[i].lowercased()
                }
            }
            return ans.joined()
        })
        
        return words.reversed().joined(separator: " ")
    }
}
