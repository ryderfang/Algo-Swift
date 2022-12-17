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
    ([5,3,6,2,4,nil,7], 28),
    ([5,3,6,2,4,nil,7], 9),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
    let root = TreeNode.arrayToTree(x.0)
//    let node = Node.arrayToNode(x)
//    var tmp = x

//    classHandler(ops: x.0, datas: x.1)
    let ans = sol.findTarget(root, x.1)

    print(ans)
//    print(ans?.array() ?? [])
//    print(tmp)
}

func classHandler(ops: [String], datas: [[Int?]]) {
    let n = ops.count
    var sut = BSTIterator(nil)
    for i in 0..<n {
        let op = ops[i]
        let data = datas[i]
        switch op {
        case "BSTIterator":
            let root = TreeNode.arrayToTree(data)
            sut = BSTIterator(root)
            print("nil")
            break
        case "next":
            print(sut.next())
        case "hasNext":
            print(sut.hasNext())
        default:
            break
        }
    }
}
