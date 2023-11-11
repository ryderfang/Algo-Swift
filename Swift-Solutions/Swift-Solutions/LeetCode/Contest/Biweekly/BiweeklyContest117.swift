//
//  BiweeklyContest117.swift
//  Titan
//
//  Created by ryfang on 2023/11/11.
//

#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func distributeCandies(_ n: Int, _ limit: Int) -> Int {
        var ans = 0
        for a in 0...limit {
            let low = max(0, n - limit - a)
            if low > limit {
                continue
            }
            let high = min(n - a, limit)
            if high < low {
                continue
            }
            ans += (high - low + 1)
        }
        return ans
    }

    // Better solution: DP
    func stringCount(_ n: Int) -> Int {
        let mod = 1000000007
        // dp[n+1][3][2][2]
        var dp = [[[[Int]]]](repeating: [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: 2), count: 2), count: 3), count: n + 1)
        dp[0][0][0][0] = 1
        for i in 0..<n {
            for j in 0..<3 {
                for k in 0..<2 {
                    for l in 0..<2 {
                        dp[i+1][min(2, j+1)][k][l] += dp[i][j][k][l]
                        dp[i+1][min(2, j+1)][k][l] %= mod
                        dp[i+1][j][min(1, k+1)][l] += dp[i][j][k][l]
                        dp[i+1][j][min(1, k+1)][l] %= mod
                        dp[i+1][j][k][min(1, l+1)] += dp[i][j][k][l]
                        dp[i+1][j][k][min(1, l+1)] %= mod

                        dp[i+1][j][k][l] += (23 * dp[i][j][k][l])
                        dp[i+1][j][k][l] %= mod
                    }
                }
            }
        }
        return dp[n][2][1][1]
    }

    // 排列组合，硬算
    func stringCount2(_ n: Int) -> Int {
        // "leet"
        // n = 10, 526083947580 % (109 + 7) = 83943898
        let mod = 1000000007
        func _pow(_ a: Int, _ b: Int) -> Int {
            if b == 0 { return 1 }
            if b == 1 { return a % mod }
            let tmp = _pow(a, b / 2)
            if b & 1 > 0 {
                return (((tmp * tmp) % mod) * a) % mod
            } else {
                return (tmp * tmp) % mod
            }
        }

        let total = _pow(26, n)
        let no_l = _pow(25, n)
        let no_t = _pow(25, n)
        let no_e = _pow(25, n) + n * _pow(25, n - 1)
        let no_lt = _pow(24, n)
        let no_le = _pow(24, n) + n * _pow(24, n - 1)
        let no_te = _pow(24, n) + n * _pow(24, n - 1)
        let no_let = _pow(23, n) + n * _pow(23, n - 1)
        return ((total - no_l - no_t - no_e + no_lt + no_le + no_te - no_let) % mod + mod) % mod
    }

    func maxSpending(_ values: [[Int]]) -> Int {
        var ans = 0
        let m = values.count
        let n = values[0].count
        typealias Pair = (i: Int, j: Int, v: Int)
        var pq = PriorityQueue<Pair>([], { $0.v < $1.v })
        for i in 0..<m {
            pq.enqueue((i: i, j: n - 1, v: values[i][n-1]))
        }
        var d = 1
        while !pq.isEmpty {
            if let last = pq.dequeue() {
                ans += d * last.v
                if last.j >= 1 {
                    pq.enqueue((i: last.i, j: last.j - 1, v: values[last.i][last.j-1]))
                }
                d += 1
            }
        }
        return ans
    }
}

fileprivate struct PriorityQueue<Element> {
    private var elements = [Element]()
    private let hasHigherPriority: (Element, Element) -> Bool
    var isEmpty: Bool { elements.count == 0 }
    var front: Element? { elements.first }

    init(_ array: [Element], _ sort: @escaping (Element, Element) -> Bool) {
        self.hasHigherPriority = sort
        for x in array {
            self.enqueue(x)
        }
    }

    mutating func enqueue(_ element: Element) {
        elements.append(element)
        bubbleToHigherPriority(elements.count - 1)
    }

    @discardableResult
    mutating func dequeue() -> Element? {
        guard let front = front else { return nil }
        removeAt(0)
        return front
    }

    private mutating func removeAt(_ index: Int) {
        let removingLast = index == elements.count - 1
        if !removingLast {
            elements.swapAt(index, elements.count - 1)
        }
        _ = elements.popLast()
        if !removingLast {
            bubbleToHigherPriority(index)
            bubbleToLowerPriority(index)
        }
    }

    private mutating func bubbleToHigherPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < elements.count)

        var unbalancedIndex = initialUnbalancedIndex
        while unbalancedIndex > 0 {
            let parentIndex = (unbalancedIndex - 1) / 2
            guard self.hasHigherPriority(elements[unbalancedIndex], elements[parentIndex]) else { break }
            elements.swapAt(unbalancedIndex, parentIndex)
            unbalancedIndex = parentIndex
        }
    }

    private mutating func bubbleToLowerPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < elements.count)

        var unbalancedIndex = initialUnbalancedIndex
        while true {
            let leftChildIndex = unbalancedIndex * 2 + 1
            let rightChildIndex = unbalancedIndex * 2 + 2
            var highestPriorityIndex = unbalancedIndex
            if leftChildIndex < elements.count && self.hasHigherPriority(elements[leftChildIndex], elements[highestPriorityIndex]) {
                highestPriorityIndex = leftChildIndex
            }
            if rightChildIndex < elements.count && self.hasHigherPriority(elements[rightChildIndex], elements[highestPriorityIndex]) {
                highestPriorityIndex = rightChildIndex
            }
            guard highestPriorityIndex != unbalancedIndex else { break }
            elements.swapAt(highestPriorityIndex, unbalancedIndex)
            unbalancedIndex = highestPriorityIndex
        }
    }
}
