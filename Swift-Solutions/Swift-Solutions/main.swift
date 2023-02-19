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
    (
    ["Trie", "insert", "search", "search", "startsWith", "insert", "search"],
    [[], ["apple"], ["apple"], ["app"], ["app"], ["app"], ["app"]])
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.0

    ClassHandler.test(ops: x.0, datas: x.1)

    print(1..<10 ~= 11)
    print(1..<10 ~= 7)

//    let ans = sol.canFinish(x.0, x.1)
//    print(ans)

//    print(ans?.array() ?? [])
//    print(tmp)
}

struct ClassHandler {
    static func test(ops: [String], datas: [[String]]) {
        let n = ops.count
        let sut = Trie()
        let className = String(describing: sut).components(separatedBy: ".").last
        for i in 0..<n {
            let op = ops[i]
            let data = datas[i]
            switch op {
            case className:
                print("null")
            case "insert":
                print("null")
                sut.insert(data[0])
            case "search":
                print(sut.search(data[0]))
            case "startsWith":
                print(sut.startsWith(data[0]))
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
