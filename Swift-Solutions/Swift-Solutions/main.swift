//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import AlgoBase

let sol = Solution()
//let cases = READNUMS()
let cases = [
    (nums1: [1,2,3,0,0,0], m: 3, nums2: [2,5,6], n: 3),
    (nums1: [1], m: 1, nums2: [], n: 0),
    (nums1: [0], m: 0, nums2: [1], n: 1)
]
for x in cases {
    var t = x.nums1
    let _ = sol.merge(&t, x.m, x.nums2, x.n)
//    print(ans)
    print(t)
}

