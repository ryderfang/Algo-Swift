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
    [3,9,20,nil,nil,15,7],
    [2,nil,3,nil,4,nil,5,nil,6],
]
for x in cases {
    let t = TreeNode.arrayToTree(x)
    let ans = sol.minDepth(t)
    print(ans)
}

