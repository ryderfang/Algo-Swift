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
    (1, []),
    (2, [[0, 1]]),
    (4, [[1,0],[1,2],[1,3]]),
    (6, [[3,0],[3,1],[3,2],[3,4],[5,4]]),
    (6, [[0,1],[0,2],[0,3],[3,4],[4,5]]),
    (10,
    [[0,1],[0,2],[0,3],[2,4],[0,5],[5,6],[6,7],[2,8],[7,9]])
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x.0)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.findMinHeightTrees(x.0, x.1)
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
