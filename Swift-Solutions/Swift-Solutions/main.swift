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
    ("5F3Z-2e-9-w", 4),
    ("2-5g-3-J", 2),
    ("2-4A0r7-4k", 3),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.licenseKeyFormatting(x.0, x.1)
    print(ans)
//    print(tmp)
}

