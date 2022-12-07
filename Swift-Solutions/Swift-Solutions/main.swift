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
    ([1,2,3,4,5], [3,4,5,1,2]),
    ([2,3,4], [3,4,3]),
    ([1,1,1,1,1,1,0,100],[0,0,0,0,0,0,100,0]),
    ([4],[5]),
    ([2],[2]),
    ([5],[4]),
    ([5,8,2,8], [6,5,6,6])
    // -1,3,-4,2
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.map { Character($0) } }
    let ans = sol.canCompleteCircuit(x.0, x.1)
    print(ans)
//    print(ans?.nextArray() ?? [])
//    print(tmp)
}





