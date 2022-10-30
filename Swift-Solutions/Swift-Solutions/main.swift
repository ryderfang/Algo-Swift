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
    [1,2,3,nil,5],
    [1],
]
for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
    let root = TreeNode.arrayToTree(x)
    let ans = sol.binaryTreePaths(root)
    print(ans)
}

