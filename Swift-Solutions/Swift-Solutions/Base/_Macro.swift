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

public func READFILE(fname: String = "testcase") -> Array<String> {
    let currentURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let bundleURL = URL(fileURLWithPath: "TestCases.bundle", relativeTo: currentURL)
    let testFile = Bundle(url: bundleURL)!.url(forResource: fname, withExtension: "txt")!
    let contentOfFile = try? String(contentsOf: testFile, encoding: .utf8)
    var lines = contentOfFile?.components(separatedBy: .newlines)
    // remove last empty line
    lines?.removeLast()
    return lines ?? [String]()
}

public func READNUMS(fname: String = "testcase") -> Array<Array<Int>> {
    var result = [[Int]]()
    let lines = READFILE(fname: fname)
    for (_, ln) in lines.enumerated() {
        let nums = ln.split(separator: " ").map({
            return Int($0)!
        })
        result.append(nums)
    }
    return result
}
