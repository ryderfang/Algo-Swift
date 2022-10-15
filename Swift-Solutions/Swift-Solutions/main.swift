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
    "Hello World",
    "   fly me   to   the moon  ",
    "luffy is still joyboy",
]
for x in cases {
    print(sol.lengthOfLastWord(x))
}

#else
Primer.p5_2()
#endif

