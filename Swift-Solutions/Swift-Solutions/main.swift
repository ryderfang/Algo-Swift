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
    ([2,3,6,7], 7),
    ([2,3,5], 8),
    ([2], 1),
    ([2,3], 6)
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
    let ans = sol.combinationSum(x.0, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

