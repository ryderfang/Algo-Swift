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
    ([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3),
    ([[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13),
    ([[1]], 1),
    ([[1],[3]], 3),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x.0)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.searchMatrix(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

