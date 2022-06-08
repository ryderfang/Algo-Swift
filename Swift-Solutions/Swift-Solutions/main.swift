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
    [1, 2, 3, 4, 5],
    [1, 2, 3],
    [0],
]
for x in cases {
//    print(sol.subsetsWithDup(x))
//    let com = Combinations()
//    print(com.subsets1(x))
    let b = BinarySearch()
    print(b.search(x, 0))
}

#else
Primer.p5_2()
#endif

