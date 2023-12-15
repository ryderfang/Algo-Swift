//
//  String+BigInt.swift
//  AlgoBase
//
//  Created by ryfang on 2023/10/24.
//

fileprivate extension String {
    // positive, no leading-zeros
    func add(_ rhs: String) -> String {
        var a = [Int]()
        var b = [Int]()
        a = self.reversed().map { Int(String($0))! }
        b = rhs.reversed().map { Int(String($0))! }
        let len = max(a.count, b.count)
        a.append(contentsOf: [Int](repeating: 0, count: len - a.count))
        b.append(contentsOf: [Int](repeating: 0, count: len - b.count))
        var carry: Int = 0
        for i in 0..<len {
            let tmp = a[i] + b[i] + carry
            a[i] = tmp % 10
            carry = tmp / 10
        }
        if carry > 0 {
            a.append(carry)
        }
        let ans = a.reversed().map { "\($0)" }.joined()
        return ans
    }
}
