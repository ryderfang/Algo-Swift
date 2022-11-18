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
    ([-1,2,1,-4], 1),
    ([0,0,0], 1),
    ([1,1,1,1], -100),
    ([1,1,1,0], -100),
    ([2,3,8,9,10], 16),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.threeSumClosest(x.0, x.1)
    print(ans)
//    print(tmp)
}

