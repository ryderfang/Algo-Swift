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
    ([2,7,11,15], 9),
    ([2,3,4], 6),
    ([-1,0], -1),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x
    let ans = sol.twoSum(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}





