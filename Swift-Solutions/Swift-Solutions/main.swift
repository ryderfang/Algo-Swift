//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import AlgoBase

let sol = Solution()

// let cases = READNUMS()

let cases = [
    "112358",
    "199100199",
    "199999999999999999989999999999999999999",
    "000",
    "00102",
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x.0)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.isAdditiveNumber(x)
    print(ans)

//    print(ans?.array() ?? [])
//    print(tmp)
}

print("\n--- <EOF> ---")

struct ClassHandler {
    static func test(ops: [String], datas: [Any]) {
        let n = ops.count
        let sut = NumMatrix(datas[0] as! [[Int]])
        for i in 1..<n {
            let op = ops[i]
            let data = datas[i] as! [Int]
            switch op {
            case "NumMatrix":
                print("null")
            case "sumRegion":
                print(
                sut.sumRegion(data[0], data[1], data[2], data[3]))
            default:
                break
            }
        }
    }
}

fileprivate extension Array where Element == String {
    func charArray() -> [Character] {
        return self.map { Character($0) }
    }
}
