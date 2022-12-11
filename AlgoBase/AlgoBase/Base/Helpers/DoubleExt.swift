//
//  DoubleExt.swift
//  AlgoBase
//
//  Created by ryfang on 2022/12/11.
//

import Foundation

fileprivate extension Double {
    // 四舍五入
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }

    // 截断
    func truncate(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return Double(Int(self * divisor)) / divisor
    }
}
