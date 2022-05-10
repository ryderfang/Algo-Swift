//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import CoreText

#if LeetCode
let sol = Solution()
//let cases = READNUMS()
let cases = [
    ([1,2,4,9,9], [1,3,4,5,6,7]),
    ([], []),
    ([], [0]),
]
for x in cases {
    let l1 = ListNode.arrayToList(x.0)
    let l2 = ListNode.arrayToList(x.1)
    let ans = sol.mergeTwoLists(l1, l2)
    print(ans?.listToArray() ?? [])
}

#else
Primer.p5_2()
#endif

