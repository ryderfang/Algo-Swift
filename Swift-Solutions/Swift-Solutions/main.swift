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
    ([1,2,3,4,5], 1, 5),
    ([5], 1, 1),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
    let head = ListNode.arrayToList(x.0)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.reverseBetween(head, x.1, x.2)
    print(ans)
    print(ans?.array() ?? [])
//    print(tmp)
}

