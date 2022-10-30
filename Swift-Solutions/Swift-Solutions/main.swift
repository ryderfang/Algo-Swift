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
//    [3,2,0,-4],
    [1,2],
//    [1],
]
for x in cases {
    let head = ListNode.arrayToList(x)
    head?.next?.next = head
    let ans = sol.hasCycle(head)
    print(ans)
}

