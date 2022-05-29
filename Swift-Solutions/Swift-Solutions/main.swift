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
//    [1, 2, 2, 3],
//    [1, 2, 3],
    [1, 2, 2],
]
for x in cases {
    let p = Permutations()
    print(p.permute(x))
    print(p.permuteUnique(x))
    print(sol.permuteUnique(x))
}

#else
Primer.p5_2()
#endif

