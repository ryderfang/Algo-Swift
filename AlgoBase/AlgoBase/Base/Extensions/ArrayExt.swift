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
}
