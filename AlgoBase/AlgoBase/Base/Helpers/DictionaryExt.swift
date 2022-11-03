//
//  DictionaryExt.swift
//  AlgoBase
//
//  Created by ryfang on 2022/11/3.
//

import Foundation

extension Dictionary {
    mutating func add(_ k: Key, _ x: Value) {
        let x = x as! Int
        self[k] = ((self[k] ?? 0 as! Value) as! Int + x) as? Value
    }

    func get(_ k: Key) -> Value {
        return self[k, default: 0 as! Value]
    }
}
