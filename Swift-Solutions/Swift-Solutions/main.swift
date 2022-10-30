//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import AlgoBase

let sol = Solution()

//class Solution {
//
//}

//let cases = READNUMS()
let cases = [
    [0,1,2,4,5,7],
    [0,2,3,4,6,8,9],
    [],
]
for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
    let ans = sol.summaryRanges(x)
    print(ans)
}

