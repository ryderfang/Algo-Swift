/*
 * @lc app=leetcode id=2054 lang=swift
 *
 * [2054] Two Best Non-Overlapping Events
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // Editorial: https://leetcode.com/problems/two-best-non-overlapping-events/solutions/6112712/two-best-non-overlapping-events/
    // Solution1: Top-down DP
    // O(nlogn)
    func maxTwoEvents1(_ events: [[Int]]) -> Int {
        let n = events.count
        let events = events.sorted(by: { $0[0] < $1[1] })
        // dp[idx][cnt] -> result start from idx, pick cnt events
        var dp = [[Int]](repeating: [Int](repeating: -1, count: 3), count: n)
        func _findEvents(_ evts: [[Int]], _ idx: Int, _ cnt: Int) -> Int {
            let n = evts.count
            if cnt == 2 || idx >= n { return 0 }
            guard dp[idx][cnt] == -1 else { return dp[idx][cnt]}
            let end = evts[idx][1]
            var lo = idx + 1, hi = n - 1
            while lo < hi {
                let mid = lo + ((hi - lo) >> 1)
                if evts[mid][0] > end {
                    hi = mid
                } else {
                    lo = mid + 1
                }
            }
            let include = evts[idx][2] + ((lo < n && evts[lo][0] > end) ? _findEvents(evts, lo, cnt + 1) : 0)
            let exclude = _findEvents(evts, idx + 1, cnt)
            dp[idx][cnt] = max(include, exclude)
            return dp[idx][cnt]
        }
        
        return _findEvents(events, 0, 0)
    }
    
    // Solution2: Min-heap
    func maxTwoEvents(_ events: [[Int]]) -> Int {
        // Element: (end, value)
        var pq = PriorityQueue<(Int, Int)>([], <)
        let events = events.sorted(by: { $0[0] < $1[0] })
        var (maxVal, ans) = (0, 0)
        for e in events {
            // Since had sorted, all elements's start should less then e[0]
            // Pop all valid events and get maxValue of them
            while !pq.isEmpty && pq.front!.0 < e[0] {
                maxVal = max(maxVal, pq.front!.1)
                pq.dequeue()
            }
            ans = max(ans, maxVal + e[2])
            pq.enqueue((e[1], e[2]))
        }
        return ans
    }
    
    // Solution3: Greedy
    func maxTwoEvents3(_ events: [[Int]]) -> Int {
        enum EventType: Int { case start = 1, end = 0 }
        typealias EventPoint = (type: EventType, time: Int, value: Int)

        var eventPoints = [EventPoint]()
        for e in events {
            // Each event, two tuples
            eventPoints.append(EventPoint(type: .start, time: e[0], value: e[2]))
            eventPoints.append(EventPoint(type: .end, time: e[1] + 1, value: e[2]))
        }
        eventPoints.sort(by: { e1, e2 in
            // same time, prioritize `end`
            (e1.time, e1.type.rawValue) < (e2.time, e2.type.rawValue)
        })
        
        var bestValue = 0
        var res = 0
        for eventPoint in eventPoints {
            switch eventPoint.type {
            case .start:
                // If the event being started, combined with the best completed
                // event so far, improves the result, update the result.
                res = max(res, bestValue + eventPoint.value)
            case .end:
                // If the event just being completed is better than any
                // previous event, update "bestValue".
                bestValue = max(bestValue, eventPoint.value)
            }
        }
        return res
    }

    // My solution
    func maxTwoEvents4(_ events: [[Int]]) -> Int {
        var ans = 0
        // one
        for e in events {
            ans = max(ans, e[2])
        }
        var mp = [[Int]: Int]()
        // remove duplicated
        for e in events {
            if let v = mp[[e[0], e[1]]] {
                mp[[e[0], e[1]]] = max(v, e[2])
            } else {
                mp[[e[0], e[1]]] = e[2]
            }
        }
        var evs = [_Event]()
        for (k, v) in mp {
            evs.append(_Event(k + [v]))
        }
        evs.sort(by: { $0.value > $1.value })
        let n = evs.count
        for i in 0..<n-1 {
            for j in i+1..<n {
                guard evs[i].value + evs[j].value > ans else { break }
                if !evs[i].overlapped(evs[j]) {
                    ans = max(ans, evs[i].value + evs[j].value)
                    break
                }
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

fileprivate struct _Event {
    var start: Int
    var end: Int
    var value: Int
    
    init(_ arr: [Int]) {
        start = arr[0]
        end = arr[1]
        value = arr[2]
    }
    
    func overlapped(_ oth: _Event) -> Bool {
        (oth.start - end) * (oth.end - start) <= 0
    }
}
// @lc code=end

