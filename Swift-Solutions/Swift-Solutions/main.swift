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
    [1]
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    let head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.map { Character($0) } }
    let head = Node(1)
    let next = Node(2)
    head.next = next
    head.random = next
    next.next = nil
    next.random = next
    let ans = sol.copyRandomList(head)
    print(ans)
//    print(ans?.nextArray() ?? [])
//    print(tmp)
}





