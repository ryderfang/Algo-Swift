//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import AlgoBase

let sol = Solution()

class Solution {
    
}

//let cases = READNUMS()
let cases = [
    ([1,2,3,1], 3),
    ([1,0,1,1], 1),
    ([1,2,3,1,2,3], 2),
    ([1], 1),
    ([99,99], 2)
]
for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
    let ans = sol.containsNearbyDuplicate(x.0, x.1)
    print(ans)
}

