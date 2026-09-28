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
    func maximumCount1(_ nums: [Int]) -> Int {
//        var pos = 0, neg = 0
//        for x in nums {
//            if x > 0 {
//                pos += 1
//            } else if x < 0 {
//                neg += 1
//            }
//        }
//        return max(pos, neg)
        return max(nums.filter { $0 > 0 }.count, nums.filter { $0 < 0 }.count)
    }

    func maximumCount(_ nums: [Int]) -> Int {
        let n = nums.count
        var pos = 0, neg = 0
        var (l, r) = (0, n - 1)
        while l <= r {
            let m = l + (r - l) / 2
            let x = nums[m]
            if x <= 0 {
                l = m + 1
            } else {
                r = m - 1
            }
        }
        pos = n - 1 - r

        (l, r) = (0, n - 1)
        while l <= r {
            let m = l + (r - l) / 2
            let x = nums[m]
            if x >= 0 {
                r = m - 1
            } else {
                l = m + 1
            }
        }
        neg = l
        print(pos, neg)
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
        struct Worker: Equatable {
            var leftToRight: Int
            var pickOld: Int
            var rightToLeft: Int
            var putNew: Int
            var index: Int
            var priority: Int
            init(_ l2r: Int, _ po: Int, _ r2l: Int, _ pn: Int, _ i: Int) {
                leftToRight = l2r
                pickOld = po
                rightToLeft = r2l
                putNew = pn
                index = i
                // since index <= 10000
                priority = (leftToRight + rightToLeft) * 10000 + index
            }
            static func == (lhs: Self, rhs: Self) -> Bool {
                return lhs.index == rhs.index
            }
        }
        struct Event: Equatable {
            var time: Int
            var worker: Worker
            init(_ time: Int, _ worker: Worker) {
                self.time = time
                self.worker = worker
            }
            static func == (lhs: Self, rhs: Self) -> Bool {
                return lhs.time == lhs.time
            }
        }
        var workers = [Worker]()
        for i in 0..<k {
            workers.append(Worker(time[i][0], time[i][1], time[i][2], time[i][3], i))
        }
        // wait on left
        var leftBridge = PriorityQueue<Worker>(workers, { $0.priority > $1.priority })
        // wait on right
        var rightBridge = PriorityQueue<Worker>([], { $0.priority > $1.priority })
        // put new, arrive left on future
        var pickNew = PriorityQueue<Event>([], { $0.time < $1.time })
        // pick old, arrive right on future
        var pickOld = PriorityQueue<Event>([], { $0.time < $1.time })
        var goods = n
        var now = 0
        while goods > 0 || !rightBridge.isEmpty || !pickOld.isEmpty {
            while !pickNew.isEmpty {
                guard let top = pickNew.front, top.time <= now else {
                    break
                }
                pickNew.dequeue()
                leftBridge.enqueue(top.worker)
            }
            while !pickOld.isEmpty {
                guard let top = pickOld.front, top.time <= now else {
                    break
                }
                pickOld.dequeue()
                rightBridge.enqueue(top.worker)
            }
            if let pr = rightBridge.dequeue() {
                now += pr.rightToLeft
                pickNew.enqueue(Event(now + pr.putNew, pr))
            } else if let pl = leftBridge.dequeue(), goods > 0 {
                goods -= 1
                now += pl.leftToRight
                pickOld.enqueue(Event(now + pl.pickOld, pl))
            } else {
                now = Int.max
                // forward to future
                if !pickNew.isEmpty {
                    now = min(now, pickNew.front?.time ?? Int.max)
                }
                if !pickOld.isEmpty {
                    now = min(now, pickOld.front?.time ?? Int.max)
                }
            }
        }

        return now
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
