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
    [3,2,0,-4],
    [1,2],
    [1],
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.map { Character($0) } }
//    head?.next?.next?.next?.next = head?.next
//    head?.next?.next = head
    let ans = sol.detectCycle(head)
    print(ans?.val ?? -1)
//    print(ans?.nextArray() ?? [])
//    print(tmp)
}





