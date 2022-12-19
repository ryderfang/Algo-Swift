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
    ([-1,0,3,5,9,12], 9),
    ([-1,0,3,5,9,12], 2),
    ([5], 5)
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x

//    ClassHandler.test(ops: x.0, datas: x.1)
    let ans = sol.search(x.0, x.1)

    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

struct ClassHandler {
    static func test(ops: [String], datas: [[Any]]) {
        let n = ops.count
        var sut: KthLargest!
        let className = String(describing: sut)
        for i in 0..<n {
            let op = ops[i]
            let data = datas[i]
            switch op {
            case className:
                sut = KthLargest(data[0] as! Int, data[1] as! [Int])
                print("nil")
            case "add":
                print(sut.add(data[0] as! Int))
            default:
                break
            }
        }
    }
}
