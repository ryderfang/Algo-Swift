/*
 * @lc app=leetcode id=313 lang=swift
 *
 * [313] Super Ugly Number
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // 与 lc264 类似，也可以用 DP 实现
    func nthSuperUglyNumber(_ n: Int, _ primes: [Int]) -> Int {
        var st = Set<Int>()
        var pq = PriorityQueue<Int>([1], <)
        var i = 0, ans = 0
        while i < n {
            if let top = pq.dequeue() {
                guard !st.contains(top) else { continue }
                for x in primes {
                    pq.enqueue(top * x)
                }
                st.insert(top)
                ans = top
                i += 1
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

// @lc code=end
