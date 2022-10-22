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
    [1,2,2,3,4,4,3],
    [1,2,2,nil,3,nil,3],
    [1,2,2,2,nil,2],
]
for x in cases {
    let t1 = TreeNode.arrayToTree(x)
//    print(t1?.array())
    let ans = sol.isSymmetric(t1)
    print(ans)
}

