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
    [[1,3,2],[4,5,2],[2,4,3]],
    [[1,3,2],[4,5,2],[1,5,5]],
    [[1,5,3],[1,5,1],[6,6,5]],
    [[10,83,53],[63,87,45],[97,100,32],[51,61,16]],
    [[90,97,78],[80,94,55],[2,51,48],[8,60,27],[17,78,63],[61,86,67],[10,52,39],[44,77,94],[2,27,28],[23,29,60],[51,88,80],[56,60,8],[93,99,94],[83,90,73],[17,99,83],[40,61,88],[65,100,29],[10,43,21],[68,82,14],[30,41,75],[40,63,11],[93,94,50],[27,75,35],[38,82,61],[76,78,17],[42,44,31],[55,84,4],[89,89,59],[14,38,18],[82,89,4],[92,98,46],[2,6,25],[100,100,24],[12,64,47],[29,44,41],[84,84,84],[62,82,45],[55,99,38],[72,85,75],[82,83,30],[54,95,75],[87,92,33],[52,78,86],[28,81,42],[89,96,100],[97,97,35],[99,99,44],[13,18,95],[51,68,91],[55,77,12],[13,40,12],[78,78,4],[22,59,96],[82,99,26],[15,64,80],[15,25,34],[86,96,53],[95,98,71],[84,90,81],[39,84,97],[69,92,66],[95,100,31],[76,81,95],[92,94,43],[6,66,12],[39,91,75],[59,94,89],[35,94,40],[93,94,8],[73,89,96],[2,46,53],[26,32,51],[41,84,77],[56,70,12],[25,76,16],[75,90,27],[98,98,38],[61,79,45],[34,60,88],[79,93,49],[25,76,23],[41,56,83],[97,97,88],[13,57,71],[40,72,58],[77,86,22],[41,41,94],[78,86,99],[36,81,5],[11,88,54]]
]

let result = [
    4,
    5,
    8,
    85,
    199,
]

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    ClassHandler.test(ops: x.0, datas: x.1)

//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x.map { $0.charArray() }

//    var tmp = x
    let ans = sol.maxTwoEvents(x)
    print(ans)
    if ans != result[i] {
        print("❌")
    } else {
        print("✅")
    }
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
