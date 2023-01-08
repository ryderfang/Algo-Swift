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
//    ("ac", "b"),
//    ("abcc", "aab"),
//    ("abcde", "fghij"),
//    ("wilfuzpxqserkdcvbgajtyhon",
//    "rlmyvwvucqxsjodbelmgjkabnxegihuwats"),
//    "IDID",
//    "III",
//    "DDI",
    "IDIDDDDIIIDDIDDI"
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.diStringMatch(x)
    print(ans)

//    print(ans?.array() ?? [])
//    print(tmp)
}

struct ClassHandler {
    static func test(ops: [String], datas: [[Int]]) {
        let n = ops.count
        let sut = RecentCounter()
        let className = String(describing: sut).components(separatedBy: ".").last
        for i in 0..<n {
            let op = ops[i]
            let data = datas[i]
            switch op {
            case className:
                print("null")
            case "ping":
                print(sut.ping(data[0]))
            default:
                break
            }
        }
    }
}
