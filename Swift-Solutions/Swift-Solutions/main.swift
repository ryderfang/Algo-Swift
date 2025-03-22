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
    (5, 3, [2, 2], [2, 3]),
    (10, 5, [2,3,5], [6,7,8]),
    (64, 0, [80, 40], [88, 88]),
    (1, 1, [1,1,1,1,2,2,1,2,1,1], [0,1,0,0,1,1,1,0,2,2]),
    (10, 10, [9], [6]),
]

let result = [
    2,
    7,
    2,
    4,
    0,
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    ClassHandler.test(ops: x.0, datas: x.1)

//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    var tmp = x
    let ans = sol.profitableSchemes(x.0, x.1, x.2, x.3)
    
    print("\(ans) ~> \(ans == result[safe: i] ? "✅" : "❌")")
//    print(ans?.array() ?? [])
//    print(tmp)
}

print("\n--- <EOF> ---")

struct ClassHandler {
    static func test(ops: [String], datas: [Any]) {
        let n = ops.count
        let sut = NumArray(datas[0] as! [Int])
        for i in 1..<n {
            let op = ops[i]
            let data = datas[i] as! [Int]
            switch op {
            case "NumArray":
                print("null")
            case "sumRange":
                print(sut.sumRange(data[0], data[1]))
            case "update":
                sut.update(data[0], data[1])
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

extension Array {
    subscript(safe index: Index) -> Element? {
        get { return self.indices ~= index ? self[index] : nil }
        set {
            if self.indices ~= index {
                self[index] = newValue!
            }
        }
    }
}
