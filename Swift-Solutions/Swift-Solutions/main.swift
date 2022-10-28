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
    1,
    2,
    5,
    10,
    30,
]
for x in cases {
    let ans = sol.getRow(x)
    print(ans)
}

