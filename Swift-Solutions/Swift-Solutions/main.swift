//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import AlgoBase

let sol = Solution()

//class Solution {
//
//}

//let cases = READNUMS()
let cases = [
    [0,1,0,3,12],
    [0,1],
    [4,2,4,0,0,3,0,5,1,0],
]
for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
    var tmp = x
    let ans = sol.moveZeroes(&tmp)
    print(ans)
    print(tmp)
}

