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
    [3,2,3],
    [2,2,1,1,1,2,2],
    [3,3,4],
]
for (i, x) in cases.enumerated() {
    print("###_\(i)_###")
    let ans = sol.majorityElement(x)
    print(ans)
}

