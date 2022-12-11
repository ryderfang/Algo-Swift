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
    (420,226),
    (-50, 8),
    (0, 3),
    (1, 2),
    (2, 1),
    (4, 333),
    (4, 3),
    (1, 3),
    (1, 6),
    (11, 13),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x
    let ans = sol.fractionToDecimal(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}





