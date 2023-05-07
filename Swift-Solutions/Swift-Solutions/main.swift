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
//    ([6,2,8,0,4,7,9,nil,nil,3,5], 2, 8),
//    ([6,2,8,0,4,7,9,nil,nil,3,5], 2, 4),
//    ([2,1], 2, 1),
    ([-1,0,3,-2,4,nil,nil,8], 3, 8)
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
    let root = TreeNode.arrayToTree(x.0)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.lowestCommonAncestor(root, root?.right, root?.left?.left?.left)
    print(ans?.val)

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
