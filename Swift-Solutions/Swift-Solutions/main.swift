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
//    "42",
//    "   -42",
//    "4193 with words",
//    "+2147483647",
//    "2147483648",
//    "-2147483648",
//    "-2147483712",
    "20000000000000000000",
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.myAtoi(x)
    print(ans)
//    print(tmp)
}

