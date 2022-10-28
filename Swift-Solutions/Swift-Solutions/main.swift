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
    "A man, a plan, a canal: Panama",
    "race a car",
    " ",
    "0P",
]
for x in cases {
    let ans = sol.isPalindrome(x)
    print(ans)
}

