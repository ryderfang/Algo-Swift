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
        struct Worker {
            var leftToRight: Int
            var pickOld: Int
            var rightToLeft: Int
            var putNew: Int
            var index: Int
            var timeLeft: Int
            init(_ l2r: Int, _ po: Int, _ r2l: Int, _ pn: Int, _ i: Int) {
                leftToRight = l2r
                pickOld = po
                rightToLeft = r2l
                putNew = pn
                index = i
                timeLeft = -1
            }
        }
        var workers = [Worker]()
        for i in 0..<k {
            workers.append(Worker(time[i][0], time[i][1], time[i][2], time[i][3], i))
        }

        // put new
        var pn = [Worker]()
        // wait on left
        var left = PriorityQueue<Worker>(workers, { w1, w2 in
            let s1 = w1.leftToRight + w1.rightToLeft
            let s2 = w2.leftToRight + w2.rightToLeft
            guard s1 == s2 else { return s1 > s2 }
            return w1.index > w2.index
        }, { $0.index == $1.index } )

        // debug
//        while let top = left.dequeue() {
//            print(top)
//        }

        enum Direction {
            case toLeft
            case toRight
        }
        // worker on bridge, to right or left
        var bridge: (Worker?, Direction) = (nil, .toRight)
        // wait on right
        var right = PriorityQueue<Worker>([], { w1, w2 in
            let s1 = w1.leftToRight + w1.rightToLeft
            let s2 = w2.leftToRight + w2.rightToLeft
            guard s1 == s2 else { return s1 > s2 }
            return w1.index > w2.index
        }, { $0.index == $1.index } )
        // pick old
        var po = [Worker]()
        var remains = n
        // pn -> left -> bridge -> po -> right -> bridge -> pn
        var ans = 0
        while true {
            var newLeft = [Worker]()
            for var w in pn {
                w.timeLeft -= 1
                if w.timeLeft == 0 {
                    w.timeLeft = w.leftToRight
                    newLeft.append(w)
                }
            }
            var newRight = [Worker]()
            for var w in po {
                w.timeLeft -= 1
                if w.timeLeft == 0 {
                    w.timeLeft = w.rightToLeft
                    newRight.append(w)
                }
            }
            if var bw = bridge.0 {
                bw.timeLeft -= 1
                if bw.timeLeft == 0 {
                    switch bridge.1 {
                    case .toLeft:
                        bw.timeLeft = bw.putNew
                        pn.append(bw)

                        // end condition
                        if remains == 0 && po.count == 0 && right.peek() == nil {
                            return ans + 1
                        }

                    case .toRight:
                        bw.timeLeft = bw.pickOld
                        po.append(bw)
                    }
                }
            } else {
                // bridge free
                if right.peek() != nil {
                    // pick one cross

                } else if po.count < remains && left.peek() != nil {
                    // pick one cross
                }
            }

            for w in newLeft {
                left.enqueue(w)
            }
            for w in newRight {
                right.enqueue(w)
            }
            ans += 1
        }

        return ans
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
