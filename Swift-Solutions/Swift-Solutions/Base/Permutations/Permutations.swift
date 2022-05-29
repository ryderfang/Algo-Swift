//
//  Permutations.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/29.
//

import Foundation

class Permutations {
    // best practice
    func permute(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }
        
        var ans = [[Int]]()
        var a = nums
        let n = nums.count
        func _p(_ index: Int) {
            if index == n {
                ans.append(a)
                return
            }
            for i in index..<n {
                a.swapAt(index, i)
                _p(index + 1)
                a.swapAt(i, index)
            }
        }
        _p(0)
        return ans
    }
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }
        
        var ans = Set<[Int]>()
        var a = nums
        let n = nums.count
        func _p(_ index: Int) {
            if index == n {
                ans.insert(a)
                return
            }
            for i in index..<n {
                a.swapAt(index, i)
                _p(index + 1)
                a.swapAt(i, index)
            }
        }
        _p(0)
        return Array(ans)
    }
    
    // 字典序全排列
    func permute_lex(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }
        
        let n = nums.count
        var ans = [[Int]]()
        var used = [Bool](repeating: false, count: n)
        let a = nums.sorted()
        func _backTracking(locatedAt index: Int, with result: inout [Int]) -> Void {
            guard index < n else {
                ans.append(result)
                return
            }
            for i in 0..<n {
                if used[i] {
                    continue
                }
                result.append(a[i])
                used[i] = true
                _backTracking(locatedAt: index + 1, with: &result)
                used[i] = false
                result.removeLast()
            }
        }
        
        var tmp = [Int]()
        _backTracking(locatedAt: 0, with: &tmp)
        return ans
    }
    
    // 字典序下一个排列
    func nextPermutation(_ nums: inout [Int]) {
        let sz = nums.count
        guard sz > 1 else {
            return
        }
        var small = -1, big = -1
        // stride to is not included
        for i in stride(from: sz - 2, to: -1, by: -1) {
            if nums[i] < nums[i + 1] {
                small = i
                break
            }
        }
        if small == -1 {
            nums.reverse()
            return
        }
        for i in stride(from: sz - 1, to: small, by: -1) {
            if nums[i] > nums[small] {
                big = i
                break
            }
        }
        nums.swapAt(small, big)
        nums[(small+1)...].reverse()
    }
    
    // 字典序第 k 个排列 (k 从 1 开始)
    func getPermutation(_ n: Int, _ k: Int) -> String {
        var p = [Int](repeating: 0, count: n)
        var t = k - 1
        // 这里其实就是中介数
        for i in stride(from: n-1, to: -1, by: -1) {
            p[i] = t % (n - i)
            t /= (n - i)
        }
        p = p.map({ $0 + 1 })
        for i in stride(from: n-1, to: 0, by: -1) {
            for j in stride(from: i - 1, to: -1, by: -1) {
                if (p[j] <= p[i]) {
                    p[i] += 1
                }
            }
        }
        return p.map({ "\($0)" }).joined()
    }
    
    func permuteUnique2(_ nums: [Int]) -> [[Int]] {
        guard !nums.isEmpty else { return [] }

        let n = nums.count
        var ans = [[Int]]()
        var used = [Bool](repeating: false, count: n)
        let a = nums.sorted()
        func _backTracking(locatedAt index: Int, with result: inout [Int]) -> Void {
            guard index < n else {
                ans.append(result)
                return
            }
            for i in 0..<n {
                if used[i] {
                    continue
                } else if (i > 0 && a[i] == a[i-1] && !used[i-1]) {
                    // 这里是唯一的区别
                    continue
                }
                result.append(a[i])
                used[i] = true
                _backTracking(locatedAt: index + 1, with: &result)
                used[i] = false
                result.removeLast()
            }
        }
        
        var tmp = [Int]()
        _backTracking(locatedAt: 0, with: &tmp)
        return ans
    }
}
