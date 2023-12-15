//
//  Combinations+Count.swift
//  AlgoBase
//
//  Created by ryfang on 2023/11/16.
//

import Foundation

public extension Combinatorics {
    // [a1, a2, a3...] -> (a1+a2+..)!/(a1! * a2! *...)
    static func calcComb(_ list: [Int]) -> Int {
        let n = list.count
        guard n > 1 else { return 1 }
        var ret = 1
        var total = list[0]
        for i in 1..<n {
            for k in 1...list[i] {
                ret = ret * (total + k) / k
            }
            total += list[i]
        }
        return ret
    }
}
