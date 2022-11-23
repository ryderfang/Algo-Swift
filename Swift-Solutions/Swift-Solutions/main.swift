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
    ([5,7,7,8,8,10], 8),
    ([5,6,6,6,8,10], 6),
    ([], 0),
    ([1], 1),
    ([1, 3], 1),
    ([2,2], 2),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.searchRange(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

