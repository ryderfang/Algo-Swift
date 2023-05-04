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
    (-3,0,3,4,0,-1,9,2),
    (-2,-2,2,2,-2,-2,2,2),
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.computeArea(x.0, x.1, x.2, x.3, x.4, x.5, x.6, x.7)
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
