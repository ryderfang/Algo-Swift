//
//  ArrayExt.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/27.
//

import Foundation

private extension Array<Int> {
    static func create2DArray(_ m: Int, _ n: Int) -> [[Int]] {
        return [[Int]](repeating: [Int](repeating: 0, count: n), count: m)
    }

    static func create3DArray(_ m: Int, _ n: Int, _ k: Int) -> [[[Int]]] {
        return [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: k), count: n), count: m)
    }

    static func create4DArray(_ m: Int, _ n: Int, _ k: Int, s: Int) -> [[[[Int]]]] {
        return [[[[Int]]]](repeating: [[[Int]]](repeating: [[Int]](repeating: [Int](repeating: 0, count: s), count: k), count: n), count: m)
    }
}

private struct HashableTriple<T1: Hashable, T2: Hashable, T3: Hashable>: Hashable {
    let first: T1
    let second: T2
    let third: T3
    
    init(_ values: (T1, T2, T3)) {
        self.first = values.0
        self.second = values.1
        self.third = values.2
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
        hasher.combine(third)
    }

    static func == (lhs: HashableTriple, rhs: HashableTriple) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second && lhs.third == rhs.third
    }
}
