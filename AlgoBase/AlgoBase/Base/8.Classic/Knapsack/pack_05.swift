//
//  pack_05.swift
//  AlgoBase
//
//  Created by Ryder Fang on 2025/3/15.
//

/* 5.1 <二维费用的背包问题>
 > N 个物品，分别有 C[] 和 D[] 两种费用，分别不超过 V 和 U，物品的价值是 W[]，求最大价值
 */

/* LeetCode 参考题目
 * 474.ones-and-zeroes
 * 879.profitable-schemes
 */

/* 5.2 算法
 > dp[v][u] = max(dp[v][u], dp[v-C_i][u-D_i] + W_i)
 */
func pack_05_1(_ V: Int, _ U: Int, _ C: [Int], _ D: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: Array(repeating: 0, count: U + 1), count: V + 1)
    for i in 0..<n {
        guard C[i] <= V && D[i] <= U else { continue }
        for v in stride(from: V, through: C[i], by: -1) {
            for u in stride(from: U, through: D[i], by: -1) {
                dp[v][u] = max(dp[v][u], dp[v-C[i]][u-D[i]] + W[i])
            }
        }
    }
    return dp[V][U]
}
