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
    ["flower","flow","flight"],
    ["dog","racecar","car"],
]
for x in cases {
    print(sol.longestCommonPrefix(x))
}

#else
Primer.p5_2()
#endif

