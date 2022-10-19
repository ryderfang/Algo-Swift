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
    [1, nil, 2, 3, 4, 5, 6],
    [],
]
for x in cases {
    let r = TreeNode.arrayToTree(x)
    print(sol.postorderTraversal(r))
    print(sol.postorderTraversal2(r))
//    print(t)
}

