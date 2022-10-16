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
    1,
    8,
    15,
    24,
    35,
    48,
    63,
    80,
    88,
    2147483647,
    2147395599,
]
for x in cases {
    print(sol.mySqrt(x))
}

#else
Primer.p5_2()
#endif

