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
//    ([[1,3],[6,9]], [2,5]),
//    ([[1,2],[3,5],[6,7],[8,10],[12,16]], [4,8]),
    ([[1,5]], [2,7])
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.insert(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

