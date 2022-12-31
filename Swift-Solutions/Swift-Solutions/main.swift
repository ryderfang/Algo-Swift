//
//  main.swift
//  Solutions
//
//  Created by Ryder Fang on 2022/4/28.
//

import Foundation
import AlgoBase

let sol = Solution()

//let cases = READNUMS()
let cases = [
    ("ab#c", "ad#c"),
    ("ab##", "c#d#"),
    ("a#c", "b"),
    ("xywrrmp","xywrrm#p"),
    ("bxj##tw", "bxj###tw"),
    ("y#fo##f", "y#fx#o##f"),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.backspaceCompare(x.0, x.1)
    print(ans)

//    print(ans?.array() ?? [])
//    print(tmp)
}

struct ClassHandler {
    static func test(ops: [String], datas: [[Int]]) {
        let n = ops.count
        var sut = MyHashMap()
        let className = String(describing: sut).components(separatedBy: ".").last
        for i in 0..<n {
            let op = ops[i]
            let data = datas[i]
            switch op {
            case className:
                sut = MyHashMap()
                print("null")
            case "put":
                sut.put(data[0], data[1])
                print("null")
            case "get":
                print(sut.get(data[0]))
            case "remove":
                sut.remove(data[0])
            default:
                break
            }
        }
    }
}
