//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation

#if LeetCode
let sol = Solution()
//let cases = READNUMS()
let cases = [
    "III",
    "LVIII",
    "MCMXCIV",
    "MCMCDXLXCIVIX",
]
for x in cases {
    print(sol.romanToInt(x))
}

#else
Primer.p5_2()
#endif

