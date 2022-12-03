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
    [1,2,3,4,5,nil,7]
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
    let node = Node.arrayToNode(x)
//    var tmp = x
    let ans = sol.connect(node)
//    print(ans)
    print(ans?.nextArray() ?? [])
//    print(tmp)
}
