//
//  LehmerCode.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/22.
//

import Foundation

// 46.permutations

class LehmerCode {
    // 排列
    var nums: [Int]
    // 中介数
    var L: [Int]
    // 序号 {0...(n!-1)}
    var index: Int
    // 排列长度 readonly
    var sz: Int {
        get {
            nums.count
        }
    }
    
    // MARK: 排列 -> 序号
    init(_ p: [Int]) {
        nums = p
        L = [Int](repeating: 0, count: p.count)
        index = 0
        order_to_code()
        code_to_index()
    }
    
    // 排列 -> 中介数
    func order_to_code() {
        // must be override
    }
    
    // 中介数 -> 序号
    func code_to_index() {
        // must be override
    }
    
    // MARK: 序号 -> 排列
    init(_ i: Int, sz: Int) {
        index = i
        L = [Int](repeating: 0, count: sz)
        nums = [Int](repeating: 0, count: sz)
        index_to_code()
        code_to_order()
    }

    // 序号 -> 中介数
    func index_to_code() {
        // must be override
    }
    
    // 中介数 -> 排列
    func code_to_order() {
        // must be override
    }
    
    func print_code_str() -> Void {
        
    }
}

// MARK: 字典序 lexicographical
class LexOrderLehmerCode : LehmerCode {
    override func order_to_code() {
        // L[i] 表示 nums[i] 右边比 nums[i] 小的数的个数
        // L[sz-1] == 0
        for i in 0..<sz-1 {
            var cnt = 0
            for j in i+1..<sz {
                if nums[j] < nums[i] {
                    cnt += 1
                }
            }
            L[i] = cnt
        }
    }
    
    override func code_to_index() {
        index = 0
        var factorial = 1
        for i in stride(from: sz - 2, to: -1, by: -1) {
            index += L[i] * factorial
            factorial *= (sz-i)
        }
    }
    
    override func index_to_code() {
        var tmp = index
        for i in stride(from: sz-1, to: -1, by: -1) {
            L[i] = tmp % (sz - i)
            tmp /= (sz - i)
        }
    }
    
    override func code_to_order() {
        nums = L.map({ $0 + 1 })
        for i in stride(from: sz-1, to: 0, by: -1) {
            for j in stride(from: i - 1, to: -1, by: -1) {
                if (nums[j] <= nums[i]) {
                    nums[i] += 1
                }
            }
        }
    }
    
    override func print_code_str() {
        print(L.map({ String($0) }).joined())
    }
}

// MARK: 邻位交换法
class SwitchOrderLehmerCode : LehmerCode {
    // 逆序对 O(n^2)，这里可以优化 (树状数组 etc.)
    func rev_order_count(_ a: [Int]) -> Int {
        let len = a.count
        var count = 0
        for i in 0..<len {
            for j in i+1..<len {
                if a[i] > a[j] {
                    count += 1
                }
            }
        }
        return count
    }
    
    // -1 means left, 1 means right
    func direction(_ idx: Int) -> Int {
        var tmp = [Int]()
        for i in 0..<sz {
            if i == idx {
                continue
            }
            if nums[i] < nums[idx] {
                tmp.append(nums[i])
            }
        }
        let rev_count = rev_order_count(tmp)
        if rev_count % 2 == 0 {
            return -1
        }
        return 1
    }
    
    func index_for_sub(_ startIdx: Int) -> Int {
        let tmp = Array(L[startIdx..<sz])
        let n = sz - startIdx
        if n == 0 {
            return 0
        }
        var ans = 0
        var factorial = 1
        for i in 0..<n-1 {
            ans += tmp[i] * factorial
            factorial *= (n - i)
        }
        return ans
    }
    
    override func order_to_code() {
        // L[i] 表示 (sz-i) 方向的反方向上比它小的数的个数
        // L[sz-1] == 0
        for i in 0..<sz {
            if direction(i) < 0 {
                for j in i+1..<sz {
                    if nums[j] < nums[i] {
                        L[sz-nums[i]] += 1
                    }
                }
            } else {
                for j in 0..<i {
                    if nums[j] < nums[i] {
                        L[sz-nums[i]] += 1
                    }
                }
            }
        }
    }
    
    override func code_to_index() {
        index = 0
        var factorial = 1
        // 与递减进位法一样
        // L[0] + L[1] * n + L[2] * n * (n-1) + ..L[i] * n!/(n-i)! + L[n-2] * (n-2)!/2!
        for i in 0..<sz-1 {
            index += L[i] * factorial
            factorial *= (sz - i)
        }
    }
    
    override func index_to_code() {
        // 与递减进位法一样
        var tmp = index
        for i in 0..<sz-1 {
            L[i] = tmp % (sz - i)
            tmp /= (sz - i)
        }
    }
    
    override func code_to_order() {
        // L[0] -> find (sz-0)'s direction & pos
        for i in 0..<sz {
            let subIndex = index_for_sub(i+1)
            var count = 0
            var j = sz - 1
            if subIndex % 2 == 0 {
                // left means L[i] is the counts of right
                while j >= 0 {
                    if nums[j] == 0 {
                        count += 1
                    }
                    if (count > L[i]) {
                        break
                    }
                    j -= 1
                }
            } else {
                // right
                j = 0
                while j < sz {
                    if nums[j] == 0 {
                        count += 1
                    }
                    if (count > L[i]) {
                        break
                    }
                    j += 1
                }
            }
            nums[j] = sz - i
        }
    }
    
    override func print_code_str() {
        print(L[0..<sz-1].reversed().map({ String($0) }).joined())
    }
}

// MARK: 递增进位法
class IncBitOrderLehmerCode : LehmerCode {
    override func order_to_code() {
        // L[i] 表示 i+1 右边比它小的数的个数，(i+1) 进制数
        // L[0] == 0
        for i in 0..<sz {
            var cnt = 0
            for j in i+1..<sz {
                if nums[j] < nums[i] {
                    cnt += 1
                }
            }
            // 这里是与字典序的区别
            L[nums[i]-1] = cnt
        }
    }
    
    override func code_to_index() {
        index = 0
        var factorial = 1
        // L[0] + L[1] * 1! + L[2] * 2! + ... + L[n-1] * (n-1)!
        for i in 1..<sz {
            index += L[i] * factorial
            factorial *= (i + 1)
        }
    }
    
    override func index_to_code() {
        var tmp = index
        for i in 1..<sz {
            L[i] = tmp % (i + 1)
            tmp /= (i + 1)
        }
    }
    
    override func code_to_order() {
        for i in stride(from: sz - 1, to: -1, by: -1) {
            var count = 0
            var j = sz - 1
            while j >= 0 {
                if nums[j] == 0 {
                    count += 1
                }
                if (count > L[i]) {
                    break
                }
                j -= 1
            }
            nums[j] = i + 1
        }
    }
    
    override func print_code_str() {
        print(L[1..<sz].reversed().map({ String($0) }).joined())
    }
}

// MARK: 递减进位法
class DecBitOrderLehmerCode : LehmerCode {
    override func order_to_code() {
        // L[i] 表示 sz-i 右边比它小的数的个数，(sz-i) 进制数
        // L[sz-1] == 0
        for i in 0..<sz {
            var cnt = 0
            for j in i+1..<sz {
                if nums[j] < nums[i] {
                    cnt += 1
                }
            }
            // 这里是与字典序的区别
            L[sz-nums[i]] = cnt
        }
    }
    
    override func code_to_index() {
        index = 0
        var factorial = 1
        // L[0] + L[1] * n + L[2] * n * (n-1) + ..L[i] * n!/(n-i)! + L[n-2] * (n-2)!/2!
        // 另一种写法: (...((L[n-2] * 3 + L[n-3]) * 4 + L[n-4]) * 5 + ... + L[1]) * n + L[0]
        for i in 0..<sz-1 {
            index += L[i] * factorial
            factorial *= (sz - i)
        }
    }
    
    override func index_to_code() {
        var tmp = index
        for i in 0..<sz-1 {
            L[i] = tmp % (sz - i)
            tmp /= (sz - i)
        }
    }
    
    override func code_to_order() {
        for i in 0..<sz {
            var count = 0
            var j = sz - 1
            // inc[i] + 1 的空位，放 sz - i
            while j >= 0 {
                if nums[j] == 0 {
                    count += 1
                }
                if (count > L[i]) {
                    break
                }
                j -= 1
            }
            nums[j] = sz - i
        }
    }
    
    override func print_code_str() {
        print(L[0..<sz-1].reversed().map({ String($0) }).joined())
    }
}


class LehmerCodeTest {
    public static func test1() {
        let cases = [
            [8, 3, 6, 7, 4, 5, 2, 1],
        ]
        for x in cases {
            let order1 = LexOrderLehmerCode(x)
            order1.print_code_str()
            print(order1.index, order1.index - 2015)
            let order2 = LexOrderLehmerCode(order1.index - 2015, sz: x.count)
            order2.print_code_str()
            print(order2.nums)
        
            let order3 = IncBitOrderLehmerCode(x)
            order3.print_code_str()
            print(order3.index, order3.index - 2015)
            let order4 = IncBitOrderLehmerCode(order3.index - 2015, sz: x.count)
            order4.print_code_str()
            print(order4.nums)
        
            let order5 = DecBitOrderLehmerCode(x)
            order5.print_code_str()
            print(order5.index, order5.index - 2015)
            let order6 = DecBitOrderLehmerCode(order5.index - 2015, sz: x.count)
            order6.print_code_str()
            print(order6.nums)
        
            let order7 = SwitchOrderLehmerCode(x)
            order7.print_code_str()
            print(order7.index, order7.index - 2015)
            let order8 = SwitchOrderLehmerCode(order7.index - 2015, sz: x.count)
            order8.print_code_str()
            print(order8.nums)
            
//            let order2015 = SwitchOrderLehmerCode(2015, sz: x.count)
//            print(order2015.L, order2015.nums)
        }
    }
}
