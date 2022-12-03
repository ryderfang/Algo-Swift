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
    [3,9,20,nil,nil,15,7],
    [1,3,nil,nil,2],
    [3,1,4,nil,nil,2],
    [3,9,20,nil,nil,15,7],
    [146,71,-13,55,nil,231,399,321,nil,nil,nil,nil,nil,-33],
    [1],
    [],
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x.0)
    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.zigzagLevelOrder(root)
    print(ans)
//    print(root?.array() ?? [])
//    print(tmp)
}
