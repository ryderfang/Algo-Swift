//
//  pack_01.swift
//  AlgoBase
//
//  Created by Ryder Fang on 2025/3/14.
//

/* 1.1 <0-1 背包问题>
 > n 个物品装入容量 V 的背包，物品体积 C[] 和价值 W[]，求解装入背包的最大价值
 * 边界条件：物品不能拆分，不能超过背包体积
 */

/* LeetCode 参考题目
 * 416.partition-equal-subset-sum
 * 494.target-sum
 * 1049.last-stone-weight-ii
 */

/* 1.2 基本思路
 > dp[i][v] = max(dp[i-1][v], dp[i-1][v-C_i] + W_i)
 * dp[i][v] -> 前 i 件物品装入 v 的背包的子问题
 * 对物品 i，有两种情况
 * 如果不放入，转化为 dp[i-1][v]
 * 如果放入，转化为 dp[i-1][v-C_i]，同时总价值 +W_i
 * T: O(nV), M: O(nV)
 */
func pack_01_1(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: Array(repeating: 0, count: V + 1), count: n + 1)
    for i in 1...n {
        for v in 0...V {
            let (cur_c, cur_w) = (C[i-1], W[i-1])
            dp[i][v] = dp[i-1][v]
            if cur_c <= v {
                dp[i][v] = max(dp[i-1][v], dp[i-1][v-cur_c] + cur_w)
            }
        }
    }
    return dp[n-1][V]
}

/* 1.3 优化空间复杂度
 * 用一维数组替代的前提
 * 计算 dp[v] 时需要的 dp[v-C[i]] 保存的还是 dp[i-1][v-C[i]]
 * 这就需要逆序从 V -> 0 计算
 */
func pack_01_2(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: 0, count: V + 1)
    for i in 0..<n {
        guard C[i] <= V else { continue }
        for v in stride(from: V, through: C[i], by: -1) {
            dp[v] = max(dp[v], dp[v-C[i]] + W[i])
        }
    }
    return dp[V]
}

/* 1.4 初始化问题
 * - 如果*没有*要求背包装满，那么 dp 初始化为 [0] 即可
 * - 如果**要求**背包必须装满，那么只有 dp[0][0] = 0，其他的都是 Int.min (未定义状态）-> lc416
 */
func pack_01_3(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: Int.min, count: V + 1)
    dp[0] = 0
    for i in 0..<n {
        guard C[i] <= V else { continue }
        for v in stride(from: V, through: C[i], by: -1) {
            if dp[v-C[i]] != Int.min {
                dp[v] = max(dp[v], dp[v-C[i]] + W[i])
            }
        }
    }
    return dp[V]
}

/* 1.5 一个常数优化
 * 最终我们要得到 dp[n][V]，只需要知道 dp[n-1][V-C[n-1]]
 * 进一步到 i 只需要计算到 dp[i-1][V-Sum(C[i+1..<n])]
 *
 */
func pack_01_4(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    let n = C.count
    var dp = Array(repeating: 0, count: V + 1)
    var sumCost = C.reduce(0, +)
    for i in 0..<n {
        sumCost -= C[i]
        guard C[i] <= V else { continue }
        let lowBound = max(V - sumCost, C[i])
        for v in stride(from: V, through: lowBound, by: -1) {
            dp[v] = max(dp[v], dp[v-C[i]] + W[i])
        }
    }
    return dp[V]
}

/* 1.x 进一步优化
 * 将物品按照重量从大到小排序，先处理更大重量的物品可以让后续循环次数更少
 * 排序增加了耗时，在数据量较少时并不一定更快
 */
func pack_01_5(_ V: Int, _ C: [Int], _ W: [Int]) -> Int {
    typealias _Item = (Int, Int)
    let n = C.count
    var items = [_Item]()
    var sumCost = 0
    for i in 0..<n {
        items.append(_Item(C[i], W[i]))
        sumCost += C[i]
    }
    // sort by cost descending order
    items.sort(by: { $0.0 > $1.0 })
    var dp = Array(repeating: 0, count: V + 1)
    
    func _zero_one_pack(_ cost: Int, _ weight: Int) {
        sumCost -= cost
        guard cost <= V else { return }
        let bound = max(V - sumCost, cost)
        for v in stride(from: V, through: bound, by: -1) {
            dp[v] = max(dp[v], dp[v-cost] + weight)
        }
    }
    
    for i in 0..<n {
        _zero_one_pack(items[i].0, items[i].1)
    }
    return dp[V]
}
