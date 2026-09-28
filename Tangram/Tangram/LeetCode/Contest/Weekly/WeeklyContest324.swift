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
    func similarPairs(_ words: [String]) -> Int {
        var ans = 0
        let n = words.count
        guard n > 1 else { return 0 }
        let sets = words.map { Set($0) }
        for i in 0..<n-1 {
            for j in i+1..<n {
                if sets[i] == sets[j] {
                    ans += 1
                }
            }
        }
        return ans
    }

    func smallestValue(_ n: Int) -> Int {
        let Limit = 100001
        var isPrime = [Bool](repeating: true, count: Limit)
        (isPrime[0], isPrime[1]) = (false, false)
        var plist = [Int]()
        for i in 2..<Limit {
            if isPrime[i] {
                plist.append(i)
            }
            for p in plist {
                guard p * i < Limit else { break }
                isPrime[p * i] = false
                // 避免重复，每个合数只需要被最小的素数筛过
                if i % p == 0 {
                    break
                }
            }
        }
        var tmp = n
        while !isPrime[tmp] {
            let pre = tmp
            var next = 0
            var i = 0
            while i < plist.count && !isPrime[tmp] {
                if tmp % plist[i] == 0 {
                    tmp /= plist[i]
                    next += plist[i]
                } else {
                    i += 1
                }
            }
            next += tmp
            tmp = next
            guard next != pre else { break }
        }
        return tmp
    }

    func isPossible(_ n: Int, _ edges: [[Int]]) -> Bool {
        var mp = [Int: Set<Int>]()
        for e in edges {
            mp[e[0], default: []].insert(e[1])
            mp[e[1], default: []].insert(e[0])
        }

        func _add(_ u: Int, _ v: Int) -> Bool {
            return !mp[u, default: []].contains(v)
        }

        var ans = [Int]()
        for (k, v) in mp {
            if v.count % 2 == 1 {
                ans.append(k)
            }
            guard ans.count <= 4 else { return false }
        }
        if ans.count == 0 {
            return true
        }
        if ans.count == 2 {
            if _add(ans[0], ans[1]) {
                return true
            }
            // 引入第三个节点，多加一条边
            for x in mp.keys {
                guard x != ans[0] && x != ans[1] else { continue }
                if _add(x, ans[0]) && _add(x, ans[1]) {
                    return true
                }
            }
            return false
        } else if ans.count == 4 {
            if _add(ans[0], ans[1]) && _add(ans[2], ans[3]) {
                return true
            }
            if _add(ans[0], ans[2]) && _add(ans[1], ans[3]) {
                return true
            }
            if _add(ans[0], ans[3]) && _add(ans[1], ans[2]) {
                return true
            }
            return false
        }
        return false
    }

    func cycleLengthQueries(_ n: Int, _ queries: [[Int]]) -> [Int] {
        var ans = [Int]()
        for q in queries {
            var (u, v) = (q[0], q[1])
            var count = 0
            while u != v {
                if u > v {
                    u /= 2
                } else {
                    v /= 2
                }
                count += 1
            }
            ans.append(count + 1)
        }
        return ans
    }
}
// @lc code=end
