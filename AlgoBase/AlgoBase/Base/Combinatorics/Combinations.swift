//
//  Combinations.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/6/3.
//

import Foundation

extension Combinatorics {
    // MARK: C(n, k)
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var ans = [[Int]]()
        func _p(_ index: Int, _ res: [Int]) {
            if res.count == k {
                ans.append(res)
                return
            }
            for i in index..<n {
                if n - i < k - res.count {
                    break
                }
                var tmp = res
                tmp.append(i + 1)
                _p(i + 1, tmp)
                tmp.removeLast()
            }
        }
        _p(0, [])
        return ans
    }
    
    // MARK: C(n, 0) + C(n, 1) + ... C(n, n)
    func subsets(_ nums: [Int]) -> [[Int]] {
        var ans = [[Int]]()
        ans.append([])
        return nums.reduce(into: ans, {
            r, c in
            r = r + r.map{ $0 + [c] }
        })
    }
    
    func subsets1(_ nums: [Int]) -> [[Int]] {
        var ans : [[Int]] = [[]]
        for num in nums {
            for item in ans {
                var tmp = item
                tmp.append(num)
                ans.append(tmp)
            }
        }
        return ans
    }
    
    func subsets2(_ nums: [Int]) -> [[Int]] {
        var ans = [[Int]]()
        let n = nums.count
        func _p(_ index: Int, _ res: [Int]) {
            ans.append(res)
            for i in index..<n {
                var tmp = res
                tmp.append(nums[i])
                _p(i + 1, tmp)
                tmp.removeLast()
            }
        }
        _p(0, [])
        return ans
    }

    // MARK: 带重复元素的子集
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var ans = Set<[Int]>()
        ans.insert([])
        for num in nums {
            for item in ans {
                var tmp = item
                tmp.append(num)
                tmp.sort()
                ans.insert(tmp)
            }
        }
        return Array(ans)
    }
    
    func subsetsWithDup1(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }

        let n = nums.count
        var ans: [[Int]] = [[]]
        let a = nums.sorted()
        func _backTracking(_ index: Int, _ result: inout [Int]) {
            guard index < n else {
                return
            }
            for i in index..<n {
                if (i > index && a[i] == a[i-1]) {
                    continue
                }
                result.append(a[i])
                ans.append(result)
                _backTracking(i + 1, &result)
                result.removeLast()
            }
        }
        
        var tmp: [Int] = []
        _backTracking(0, &tmp)
        return ans
    }
}
