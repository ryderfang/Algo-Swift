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
    ([5,4,8,11,nil,13,4,7,2,nil,nil,5,1], 22),
    ([1,2,3], 5),
    ([1,2], 0),
    ([1,2], 1)
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
    let root = TreeNode.arrayToTree(x.0)
//    var tmp = x
    let ans = sol.pathSum(root, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}
