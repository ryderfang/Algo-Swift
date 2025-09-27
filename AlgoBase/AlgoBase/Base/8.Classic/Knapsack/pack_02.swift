//
//  pack_02.swift
//  AlgoBase
//
//  Created by Ryder Fang on 2025/3/22.
//

/* 2.1 <完全背包问题>
 > n 个物品装入容量 V 的背包，**每个物品可以无限使用**，物品体积 C[] 和价值 W[]，求解装入背包的最大价值
 * 边界条件：物品不能拆分，不能超过背包体积
 */

/* LeetCode 参考题目
 * 322.coin-change (求最小价值，镜像问题)
 * 518.coin-change-ii (求组合数，不考虑顺序) -> 先遍历物品
 * 377.combination-sum-iv (求排列数，考虑顺序) -> 先遍历容量
 */

/* 2.2 基本思路
 > dp[i][v] = max{dp[i-1][v-k*C_i] + k*W_i}, 0 <= k*C_i <= v
 * dp[i][v] -> 前 i 件物品装入 v 的背包的子问题
 * 对物品 i，有取 0 件，取 1 件，...，取 ⌊V/C_i⌋ 件
 * T: O(nVΣ(V/C_i)), M: O(nV)
 */
func pack_02_1(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: 0, count: V + 1)
    for i in 0..<n {
        for v in stride(from: V, to: 0, by: -1) {
            for k in stride(from: v / C[i], to: 0, by: -1) {
                dp[v] = max(dp[v], dp[v - k * C[i]] + k * W[i])
            }
        }
    }
    return dp[V]
}

/* 2.5 O(VN) 的算法
 * F[i, v] = max(F[i − 1, v], F[i, v − C_i] + W_i)
 * 与 0-1 背包的区别在于 v 是升序，因为物品可重复选取
 */
// MARK: - BEST
func pack_02_05(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: 0, count: V + 1)
    for i in 0..<n {
        guard C[i] <= V else { continue }
        for v in C[i]...V {
            dp[v] = max(dp[v], dp[v-C[i]] + W[i])
        }
    }
    return dp[V]
}
