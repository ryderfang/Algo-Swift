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
    ([3,2,1,4,5], 4),
    ([2,3,1], 3),
    ([2,5,1,4,3,6], 1),
    ([10,13,15,5,12,4,3,6,14,11,9,1,8,2,7], 7)
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.countSubarrays(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

