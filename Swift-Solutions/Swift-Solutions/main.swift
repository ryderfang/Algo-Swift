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
    [[1,3],[2,6],[8,10],[15,18]],
    [[1,4],[4,5]],
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.merge(x)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

