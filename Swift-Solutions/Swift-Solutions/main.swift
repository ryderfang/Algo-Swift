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
//    ([4,5,6,7,0,1,2], 0),
//    ([4,5,6,7,0,1,2], 3),
//    ([1], 0),
    ([1,0,1,1,1], 0),
    ([1,1,1,1,1,1,1,1,1,1,1,1,1,2,1,1,1,1,1], 2)
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.search(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

