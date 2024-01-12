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
    [1,3],
    [5,1,6],
    [3,4,5,6,7,8],
//    [2,1,1,2], // t
//    [1,2,3,4], // f
//    [1,1,1,2,1], // t
//    [3,3,4,2,2], // f
//    [1,1,2,1,1], // t
//    [1,1,2,2,1,1], // t
//    [3,3,3,2,1,1], // f
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    ClassHandler.test(ops: x.0, datas: x.1)

//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    var tmp = x
    let ans = sol.subsetXORSum(x)
    print(ans)
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
