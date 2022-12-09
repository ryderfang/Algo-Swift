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
    [[2], [1, 1], [2, 2], [1], [3, 3], [2], [4, 4], [1], [3], [4]],
    [[2],[2,1],[2,2],[2],[1,1],[4,1],[2]],
    [[2],[2],[2,6],[1],[1,5],[1,2],[1],[2]]
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x
    let lru = LRUCache(x[0][0])
    print("null")
    for od in x.dropFirst() {
        if od.count == 1 {
            print(lru.get(od[0]))
        } else {
            print("null")
            lru.put(od[0], od[1])
        }
    }
//    let _ = sol.reorderList(head)
//    print(head?.array() ?? [])
//    print(tmp)
}





