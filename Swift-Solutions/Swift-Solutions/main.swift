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
    [2,3,1,1,4],
    [2,3,0,1,4],
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let tmp = x.map {
//        $0.map {
//            Character($0)
//        }
//    }
    let ans = sol.jump(x)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

