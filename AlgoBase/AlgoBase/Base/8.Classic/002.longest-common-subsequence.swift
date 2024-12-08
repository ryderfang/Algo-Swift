//
//  002.longest-common-subsequence.swift
//  AlgoBase
//
//  Created by ryfang on 2024/12/8.
//

import Foundation

// lc1143
func longestCommonSubsequence(_ text1: String, _ text2: String) -> Int {
    let n1 = text1.count
    let n2 = text2.count
    guard n1 > 0 && n2 > 0 else { return 0 }
    let a = Array(text1), b = Array(text2)
    var ans = 0
    var dp = [[Int]](repeating: [Int](repeating: 0, count: n2 + 1), count: n1 + 1)
    for i in 1...n1 {
        for j in 1...n2 {
            dp[i][j] = (a[i-1] == b[j-1]) ? dp[i-1][j-1] + 1 : max(dp[i-1][j], dp[i][j-1])
            ans = max(ans, dp[i][j])
        }
    }
    return ans
}
