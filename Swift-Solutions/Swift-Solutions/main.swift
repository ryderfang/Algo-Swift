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
    2147483647,
    -2147483648,
    0,
    -1,
    1563847412,
    123,
    -123,
    120,
    1463847412,
    -1563847412,
    -2147483412,
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.reverse(x)
    print(ans)
//    print(tmp)
}

