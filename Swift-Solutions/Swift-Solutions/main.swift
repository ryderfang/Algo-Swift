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
    [2,3,2],
    [1,2,3,1],
    [1,2,3],
    [200,3,140,20,10],
    // 27
    [6,6,4,8,4,3,3,10],
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.0

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.rob(x)
    print(ans)

//    print(ans?.array() ?? [])
//    print(tmp)
}

struct ClassHandler {
    static func test(ops: [String], datas: [[String]]) {
        let n = ops.count
        let sut = WordDictionary()
        let className = String(describing: sut).components(separatedBy: ".").last
        for i in 0..<n {
            let op = ops[i]
            let data = datas[i]
            switch op {
            case className:
                print("null")
            case "addWord":
                print("null")
                sut.addWord(data[0])
            case "search":
                print(sut.search(data[0]))
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
