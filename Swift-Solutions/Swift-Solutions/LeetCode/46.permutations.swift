/*
 * @lc app=leetcode id=46 lang=swift
 *
 * [46] Permutations
 */

import Darwin

// @lc code=start
extension Solution {
    //MARK: 回溯
    func permute1(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        func _p(_ a: [Int], _ l: Int, _ r: Int) {
            var tmp = a
            if l == r {
                ans.append(a)
                return
            }
            for i in l...r {
                tmp.swapAt(l, i)
                _p(tmp, l + 1, r)
                tmp.swapAt(i, l)
            }
        }
        _p(nums, 0, nums.count - 1)
        TOCK()
        return ans
    }
    
    //MARK: 插入法
    func permute2(_ nums: [Int]) -> [[Int]] {
        TICK()
//        let ans : [[Int]] = nums.reduce([[]], { partialResult, a in
//            var nextResult = [[Int]]()
//            for lastArray in partialResult {
//                let sz = lastArray.count
//                // 将 a 插入到 n-1 排列中的 sz 个位置
//                for i in (0...sz) {
//                    // ArraySlice<Int> 类型
//                    let temp = lastArray[0..<i] + [a] + lastArray[i..<sz]
//                    nextResult.append(Array(temp))
//                }
//            }
//            return nextResult
//        })
        
        var ans : [[Int]] = [[]]
        for i in 0..<nums.count {
            var nextResult = [[Int]]()
            for (_, item) in ans.enumerated() {
                let sz = item.count
                // 将 a 插入到 n-1 排列中的 sz 个位置
                for k in (0...sz) {
                    // ArraySlice<Int> 类型
                    let temp = item[0..<k] + [nums[i]] + item[k..<sz]
                    nextResult.append(Array(temp))
                }
            }
            ans = nextResult
        }
        
        TOCK()
        return ans
    }
    
    //MARK: 字典序
    // O(n!*n)
    func permute3(_ nums: [Int]) -> [[Int]] {
        TICK()
        let nextPermutation : ([Int]) -> [Int]? = {
            array in
            var result = array
            let sz = array.count
            var j = -1
            // 找到第一个比后面数小的数
            for i in (0..<sz-1).reversed() {
                if result[i] < result[i+1] {
                    j = i;
                    break;
                }
            }
            // 找不到说明已经是全逆序，即最后一个排列
            if (j == -1) {
                return nil
            }
            var k = -1
            // 找到 [j+1, sz) 中比 j 大的数中最小的一个 k
            // 第一个就是最小的，因为 [j+1, sz) 是递减的
            for i in (j+1..<sz).reversed() {
                if result[i] > result[j] {
                    k = i
                    break
                }
            }
            // 交换 j - k
            result.swapAt(j, k)
            // [j+1, sz)
            result = Array(result[0...j] + result[j+1..<sz].reversed())
            return result
        }
        var ans = [[Int]]()
        ans.append(nums.sorted())
        while let next = nextPermutation(ans.last!) {
            ans.append(next)
        }
        TOCK()
        return ans
    }
    
    //MARK: 逆字典序
    func _permute3(_ nums: [Int]) -> [[Int]] {
        TICK()
        let lastPermutation : ([Int]) -> [Int]? = {
            array in
            var result = array
            let sz = array.count
            var j = -1
            // 找到第一个比后面数大的数
            for i in (0..<sz-1).reversed() {
                if result[i] > result[i+1] {
                    j = i;
                    break;
                }
            }
            // 找不到说明已经是全递增，即最小的排列
            if (j == -1) {
                return nil
            }
            var k = -1
            // 找到 [j+1, sz) 中比 j 小的数中最大的一个 k
            // 第一个就是最大的，因为 [j+1, sz) 是递增的
            for i in (j+1..<sz).reversed() {
                if result[i] < result[j] {
                    k = i
                    break
                }
            }
            // 交换 j - k
            result.swapAt(j, k)
            // [j+1, sz)
            result = Array(result[0...j] + result[j+1..<sz].reversed())
            return result
        }
        var ans = [[Int]]()
        ans.append(nums.sorted(by: >))
        while let next = lastPermutation(ans.last!) {
            ans.append(next)
        }
        TOCK()
        return ans
    }
    
    //MARK: 递归
    func permute4(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        func _p(_ a: [Int], _ result: [Int]) {
            let sz = a.count
            if sz == 0 {
                ans.append(result)
                return
            }
            for i in 0..<sz {
                let rest = Array(a[0..<i] + a[i+1..<sz])
                _p(rest, result + [a[i]])
            }
        }
        _p(nums, [])
        TOCK()
        return ans
    }
    
    //MARK: 邻位交换法
    func permute5(_ nums: [Int]) -> [[Int]] {
        TICK()
        var a = nums
        let sz = a.count
        var ans = [[Int]]()
        // -1 means left, 1 means right
        var directions = [Int](repeating: -1, count: sz)
        func _movable() -> Int? {
            var max = 1
            var pos = -1
            for i in 0..<sz {
                if a[i] < max {
                    continue
                }
                if (directions[i] > 0 && i < sz - 1 && a[i] > a[i+1]) ||
                    (directions[i] < 0 && i > 0 && a[i] > a[i-1]) {
                    max = a[i]
                    pos = i
                }
            }
            if (pos >= 0) {
                return pos
            }
            return nil
        }
        ans.append(a)
        while let max_i = _movable() {
            let max_v = a[max_i]
            a.swapAt(max_i, max_i + directions[max_i])
            // 注意：方向也要跟着交换
            directions.swapAt(max_i, max_i + directions[max_i])
            ans.append(a)
            for i in 0..<sz {
                if (a[i] > max_v) {
                    directions[i] = -directions[i]
                }
            }
        }
        TOCK()
        return ans
    }
    
    // MARK: Heap 算法
    // 优化后 (测试发现竟然更慢了)
    func permute6(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        func _heap(k: Int, a: inout [Int]) {
            if k == 1 {
                ans.append(a)
                return
            }
            for i in 0..<k {
                _heap(k: k-1, a: &a)
                if i < k-1 {
                    if k % 2 == 0 {
                        a.swapAt(i, k-1)
                    } else {
                        a.swapAt(0, k-1)
                    }
                }
            }
        }
        var a = nums
        _heap(k: a.count, a: &a)
        TOCK()
        return ans
    }
    
    // 原始的实现
    func _permute6(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        func _heap(k: Int, a: inout [Int]) {
            if k == 1 {
                ans.append(a)
                return
            }
            // Generate permutations with k-th unaltered
            // Initially k = length(A)
            _heap(k: k-1, a: &a)
            // Generate permutations for k-th swapped with each k-1 initial
            for i in 0..<k-1 {
                // Swap choice dependent on parity of k (even or odd)
                if k % 2 == 0 {
                    a.swapAt(i, k-1)
                } else {
                    a.swapAt(0, k-1)
                }
                _heap(k: k-1, a: &a)
            }
        }
        var a = nums
        _heap(k: a.count, a: &a)
        TOCK()
        return ans
    }
    
    // MARK: 递增进位法
    func permute7(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        let sz = nums.count
        var inc = [Int](repeating: 0, count: sz)
        // inc[i] 表示 (i+1) 右边比它的小的数的个数，是 (i+1) 进制数
        // inc[0] 总是 0
        func _outInc() -> String {
            let rev : [String] = inc[1...].reversed().map({ String($0) })
            return rev.joined()
        }
        
        // 最低位是 2 进制，递增时进位多
        func _increace() -> Bool {
            var i = 1
            var carry = 1
            while i < sz {
                if carry == 0 {
                    break
                }
                let sum = inc[i] + carry
                inc[i] = sum % (i + 1)
                carry = sum / (i + 1)
                i += 1
            }
            // 如果还有进位，说明已经到了最大的排列
            return (carry == 0)
        }
        
        func _next() -> Bool {
            // 根据当前中介数求排列
            var p = [Int](repeating: 0, count: sz)
            for i in (0..<sz).reversed() {
                var count = 0
                var j = sz - 1
                // inc[i] + 1 的空位，放 sz - i
                while j >= 0 {
                    if p[j] == 0 {
                        count += 1
                    }
                    if (count > inc[i]) {
                        break
                    }
                    j -= 1
                }
                // p[j] = i + 1
                p[j] = nums[i]
            }
            ans.append(p)
            
            //print(_outInc())
            // 中介数 + 1
            return _increace()
        }
        
        while _next() {
            
        }
        TOCK()
        return ans
    }
    
    // MARK: 递减进位法
    func permute8(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        let sz = nums.count
        var inc = [Int](repeating: 0, count: sz)
        // inc[i] 表示 (n-i) 右边比它的小的数的个数，是 (n-i) 进制数
        // inc[sz-1] 总是 0
        func _outInc() -> String {
            let rev : [String] = inc[0..<sz-1].reversed().map({ String($0) })
            return rev.joined()
        }
        
        // 最低位是 n 进制，递增时进位少
        func _increace() -> Bool {
            var i = 0
            var carry = 1
            while i < sz - 1 {
                if carry == 0 {
                    break
                }
                let sum = inc[i] + carry
                inc[i] = sum % (sz - i)
                carry = sum / (sz - i)
                i += 1
            }
            // 如果还有进位，说明已经到了最大的排列
            return (carry == 0)
        }
        
        func _next() -> Bool {
            // 根据当前中介数求排列
            var p = [Int](repeating: 0, count: sz)
            for i in 0..<sz {
                var count = 0
                var j = sz - 1
                // inc[i] + 1 的空位，放 sz - i
                while j >= 0 {
                    if p[j] == 0 {
                        count += 1
                    }
                    if (count > inc[i]) {
                        break
                    }
                    j -= 1
                }
                // p[j] = sz - i
                p[j] = nums[sz - i - 1]
            }
            ans.append(p)
            
            //print(_outInc())
            // 中介数 + 1
            return _increace()
        }
        
        while _next() {
            
        }
        TOCK()
        return ans
    }
    
    // MARK: QuickPerm 算法
    func permute9(_ nums: [Int]) -> [[Int]] {
        TICK()
        var ans = [[Int]]()
        var a = nums
        // init: [0,0,0...0]
        var p = [Int](repeating: 0, count: a.count)
        ans.append(a)
        var i = 1
        var j : Int
        while i < a.count {
            if (p[i] < i) {
                // if i is odd, j = p[i]; else 0
                j = i % 2 * p[i]
                // swap(a[i], a[j])
                (a[i], a[j]) = (a[j], a[i])
                ans.append(a)
                p[i] += 1
                i = 1
            } else {
                p[i] = 0
                i += 1
            }
            print(p)
        }
        TOCK()
        return ans
    }
}
// @lc code=end

