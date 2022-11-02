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
    ("abba", "dog cat cat dog"),
    ("abba", "dog cat cat fish"),
    ("aaaa", "dog cat cat dog"),
    ("abba", "dog dog dog dog"),
    ("abc", "b c a"),
]
for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    var tmp = x
    let ans = sol.wordPattern(x.0, x.1)
    print(ans)
//    print(tmp)
}

