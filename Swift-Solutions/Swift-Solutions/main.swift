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
    [1,2,3,1],
    [1,2,1,3,5,6,4],
    [2,1],
    [1,2,1,2,1],
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x
    let ans = sol.findPeakElement(x)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}





