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
    ("11", "1"),
    ("101011", "101111"),
]
print(Int(("0" as UnicodeScalar).value))
for x in cases {
    print(sol.addBinary(x.0, x.1))
}

#else
Primer.p5_2()
#endif

