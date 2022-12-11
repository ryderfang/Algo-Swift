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
    ("aba", "cdc"),
    ("aaa", "bbb"),
    ("aaa", "aaa"),
    ("aefawfawfawfaw", "aefawfeawfwafwaef"),
    ("a", "aaa"),
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x

//    classHandler(ops: x.0, datas: x.1)
    let ans = sol.findLUSlength(x.0, x.1)

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
            print("null")
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





