//
//  Defines.swift
//  Solutions
//
//  Created by ryfang on 2022/10/15.
//

// globally import
@_exported import AlgoBase

public func READFILE(fname: String = "testcase") -> [String] {
    let currentURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    let bundleURL = URL(fileURLWithPath: "TestCases.bundle", relativeTo: currentURL)
    let testFile = Bundle(url: bundleURL)!.url(forResource: fname, withExtension: "txt")!
    let contentOfFile = try? String(contentsOf: testFile, encoding: .utf8)
    var lines = contentOfFile?.components(separatedBy: .newlines)
    // remove last empty line
    lines?.removeLast()
    return lines ?? [String]()
}

public func READNUMS(fname: String = "testcase") -> [[Int]] {
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

// Globally
class Solution {

}

// lc278
public protocol VersionControl {
    func isBadVersion(_ version: Int) -> Bool
}

extension VersionControl {
    func isBadVersion(_ version: Int) -> Bool {
        false
    }
}

// lc374
public protocol GuessGame {
    func guess(_ num: Int) -> Int
}

extension GuessGame {
    func guess(_ num: Int) -> Int {
        -1
    }
}
