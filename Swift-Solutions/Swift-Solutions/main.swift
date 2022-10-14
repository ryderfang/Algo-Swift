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
    [1,1,1,1,2,2,2,3,4,4],
    [1,1,2],
    [0,0,1,1,1,2,2,3,3,4],
]
for x in cases {
    var tmp = x
    print(sol.removeDuplicates(&tmp))
    print(tmp)
}

#else
Primer.p5_2()
#endif

