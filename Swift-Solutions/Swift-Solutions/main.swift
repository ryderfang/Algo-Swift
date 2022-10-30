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
    ("egg", "add"),
    ("foo", "bar"),
    ("paper", "title"),
    ("badc", "baba"),
]
for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
    let ans = sol.isIsomorphic(x.0, x.1)
    print(ans)
}

