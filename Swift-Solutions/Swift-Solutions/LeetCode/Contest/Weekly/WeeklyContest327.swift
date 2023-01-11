//
//  WeeklyContest.swift
//  Titan
//
//  Created by ryfang on 2022/11/26.
//

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    func maximumCount(_ nums: [Int]) -> Int {
        var pos = 0, neg = 0
        for x in nums {
            if x > 0 {
                pos += 1
            } else if x < 0 {
                neg += 1
            }
        }
        return max(pos, neg)
    }

    func maxKelements(_ nums: [Int], _ k: Int) -> Int {
        var pq = PriorityQueue<Int>(nums, >)
        var ans = 0
        for _ in 0..<k {
            if let first = pq.dequeue() {
                ans += first
                pq.enqueue(Int(ceil(Double(first) / 3)))
            }
        }
        return ans
    }

    func isItPossible(_ word1: String, _ word2: String) -> Bool {
        var mp1 = [Character: Int]()
        for ch in word1 {
            mp1[ch, default: 0] += 1
        }
        var mp2 = [Character: Int]()
        for ch in word2 {
            mp2[ch, default: 0] += 1
        }
        let n1 = mp1.count
        let n2 = mp2.count
        for (k1, v1) in mp1 {
            for (k2, v2) in mp2 {
                var (t1, t2) = (n1, n2)
                if k1 == k2 {
                    if n1 == n2 { return true }
                    continue
                }
                if v1 == 1 {
                    t1 -= 1
                }
                if mp1[k2] == nil {
                    t1 += 1
                }
                if v2 == 1 {
                    t2 -= 1
                }
                if mp2[k1] == nil {
                    t2 += 1
                }
                guard t1 != t2 else { return true }
            }
        }
        return false
    }

    func findCrossingTime(_ n: Int, _ k: Int, _ time: [[Int]]) -> Int {
        let L2N = [Int]()
        let L2R = [Int]()
        let bridge = [Int]()
        let R2L = [Int]()
        let R2O = [Int]()
        return 0
    }
}

fileprivate struct PriorityQueue<Element> {
    private let hasHigherPriority: (Element, Element) -> Bool
    private let isEqual: (Element, Element) -> Bool

    private var elements = [Element]()

    init(_ array: [Element], _ sort: @escaping (Element, Element) -> Bool) where Element: Equatable {
        self.init(array, sort, { $0 == $1 })
    }

    init(_ array: [Element], _ hasHigherPriority: @escaping (Element, Element) -> Bool, _ isEqual: @escaping (Element, Element) -> Bool) {
        self.hasHigherPriority = hasHigherPriority
        self.isEqual = isEqual
        for x in array {
            self.enqueue(x)
        }
    }

    mutating func enqueue(_ element: Element) {
        elements.append(element)
        bubbleToHigherPriority(elements.count - 1)
    }

    func peek() -> Element? {
        elements.first
    }

    var isEmpty: Bool {
        elements.count == 0
    }

    mutating func dequeue() -> Element? {
        guard let front = peek() else { return nil }
        removeAt(0)
        return front
    }

    mutating func remove(_ element: Element) {
        for i in 0 ..< elements.count {
            if self.isEqual(elements[i], element) {
                removeAt(i)
                return
            }
        }
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
