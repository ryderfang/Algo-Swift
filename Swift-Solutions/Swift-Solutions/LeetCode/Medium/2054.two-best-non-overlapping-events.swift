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
    


    // My solution
    func maxTwoEvents(_ events: [[Int]]) -> Int {
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

