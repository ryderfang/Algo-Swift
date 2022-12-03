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
//    ([3,9,20,15,7], [9,3,15,20,7]),
    ([-1], [-1]),
    ([1,2], [2,1]),
    ([9,3,15,20,7], [9,15,7,20,3]),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x.0)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.buildTree(x.0, x.1)
//    print(ans)
    print(ans?.array() ?? [])
//    print(tmp)
}
