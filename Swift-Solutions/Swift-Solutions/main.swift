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
//    [100,4,200,1,3,2],
//    [0,3,7,2,5,8,4,6,0,1],
    [1,2,0,1],
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x
    let ans = sol.longestConsecutive(x)
    print(ans)
//    print(ans?.nextArray() ?? [])
//    print(tmp)
}
