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
    ([1, 2, 3], [1, 2, 3]),
    ([1, 2], [1, nil, 2]),
    ([1, 2, 1], [1, 1, 2]),
]
for x in cases {
    let t1 = TreeNode.arrayToTree(x.0)
    let t2 = TreeNode.arrayToTree(x.1)
    let ans = sol.isSameTree(t1, t2)
    print(ans)
}

