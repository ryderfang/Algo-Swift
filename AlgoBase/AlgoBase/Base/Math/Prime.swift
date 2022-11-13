//
//  Prime.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/13.
//

import Foundation

class Prime {
    static func isPrime(_ n: Int) -> Bool {
        guard n > 1 else { return false }
        if n % 2 == 0 {
            return false
        }
        for i in stride(from: 3, to: Int(sqrt(Double(n))) + 1, by: 2) {
            if n % i == 0 {
                return false
            }
        }
        return true
    }
}
