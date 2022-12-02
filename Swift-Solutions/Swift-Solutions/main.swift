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
    ("aabcc", "dbbca", "aadbbcbcac"),
    ("aabcc", "dbbca", "aadbbbaccc"),
    ("", "", ""),
    ("aabc", "abad", "aabcabad"),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x.0)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.isInterleave(x.0, x.1, x.2)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
//    for x in ans {
//        print(x?.array().map { $0 != nil ? $0! : nil } ?? [])
//    }
}

