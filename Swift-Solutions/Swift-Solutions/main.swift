//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation

#if LeetCode
let sol = Solution()
//let cases = READNUMS()
let cases = [
//    [[1,4,5],[1,3,4],[2,6]],
//    [],
//    [[]],
    [[1],[2],[3],[4],[5],[6]]
]
for x in cases {
    var lists = [ListNode?]()
    for t in x {
        lists.append(ListNode.arrayToList(t))
    }
    print(sol.mergeKLists(lists)?.array() ?? [] as [Int])
}

#else
Primer.p5_2()
#endif

