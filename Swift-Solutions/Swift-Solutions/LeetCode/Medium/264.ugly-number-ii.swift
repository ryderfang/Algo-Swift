/*
 * @lc app=leetcode id=264 lang=swift
 *
 * [264] Ugly Number II
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 丑数
    // cases:
    // 1352 -> 402653184 = 2^27 * 3
    // 1690 -> 2123366400 = 2^20 * 3^4 * 5^2
    func nthUglyNumber2(_ n: Int) -> Int {
        var pq = PriorityQueue<Int>([], <)
        pq.enqueue(1)
        var ans = -1
        var count = 0
        while count < n {
            var top = pq.dequeue()
            // remove duplicated items
            while top == ans {
                top = pq.dequeue()
            }
            if let v = top {
                pq.enqueue(v * 2)
                pq.enqueue(v * 3)
                pq.enqueue(v * 5)
                ans = v
                count += 1
            }
        }
        return ans
    }

    // sol2 - dp
    func nthUglyNumber(_ n: Int) -> Int {
        var (p2, p3, p5) = (0, 0, 0)
        // p2 - 表示上一个由乘 2 得到的 ugly 数的序号
        var dp = [Int](repeating: 1, count: n)
        for i in 0..<n-1 {
            dp[i+1] = min(dp[p2] * 2, dp[p3] * 3, dp[p5] * 5)
            if dp[i+1] == dp[p2] * 2 {
                p2 += 1
            }
            if dp[i+1] == dp[p3] * 3 {
                p3 += 1
            }
            if dp[i+1] == dp[p5] * 5 {
                p5 += 1
            }
        }
        return dp[n-1]
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

// @lc code=end
