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
    ([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED"),
    ([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "SEE"),
    ([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCB"),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x.0)
//    let root = TreeNode.arrayToTree(x)
    var tmp = x.0.map {
        $0.map {
            Character($0)
        }
    }
    let ans = sol.exist(tmp, x.1)
    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

