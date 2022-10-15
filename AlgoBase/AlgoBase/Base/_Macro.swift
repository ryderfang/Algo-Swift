//
//  MyMacro.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/5/2.
//

import Foundation

var g_start_time = NSDate()

public func TICK() {
    g_start_time = NSDate()
}

public func TOCK(function: String = #function) {
    print(String(format: "[%@] cost: %.2lf s", function, -g_start_time.timeIntervalSinceNow))
}
