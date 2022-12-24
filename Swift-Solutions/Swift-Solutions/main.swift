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
    ("K; P; u, M' o. W! S; y? y, k, T' t; M, E, N? Q! J, w' x. s; S. Y. R; V, P? U; P? o; g? W, N; N' S, W, h, Z' T? t! l' T? x! K; o. F? q. w? Q, s? Q! m; g? x? R; L' q, C; f! E? x? T; f, r! O. K! P, x. z; l' j. Y, S! w? w, j. U; s, M? r' J? Z. x; T. z; Q; Q? J' w' W, p! V, P; t! x? o; G' z' u, V, C' S; O? I; g, r. C? y. t! O, t' n. y. Q. N? L. t; I, X' W; w! M; m? Y? f? Z. s? x? U. q! I, i, v! p, V! Z; z; F! D. R, r' y. r' v. j! Y, M! U. M, p; Y, u' P, t, R. w? S! W. X. U? R? X' s, e. w' V; I' Y; z? l! s, u! z! R' a; R' y' S' Q? l, j, L; W. V! w; V, y? R! h. V. L, Y. X, Y' Q? U; y, n! V, y? N; V; x' H' U? K; O! X! d. U, W' U' x. Y; L' X, T? t, V, L; r! k! u' N. y; P. S, e! j, X! t' Z; s? y! u; n' K, T, Z. w. l! Y; g' x, H; U' D! Y? e, b, W. X! u; W; v, S. Z, y? o? K, P? Q? Z, Y' P; n. V? h; J, v! v; X; V. s. y. g' m? l, X. K! u? O? j; u, n' T. O' S; W. U; m. G! Z! Z, K, v. q. Z? q; Z; o? P? I. X, z! t! w' v. z! N' o! M' Z' Z? V. S; Q. O; Z! k. X! r! w. T! q. M? n, I, M; R, d, h; Z, z' n,", ["n","q","l","i","u","d","h","o","y","b","c","t","v","a","x","m","k","w","s","z"]),
    ("Bob. hIt, baLl", ["bob", "hit"])
]

//let dummy = NumArray([-2, 0, 3, -5, 2, -1])

for (i, x) in cases.enumerated() {
    print("--- <\(i+1)> ---")
//    var head = ListNode.arrayToList(x)
//    let root = TreeNode.arrayToTree(x)
//    let node = Node.arrayToNode(x)
//    var tmp = x

//    ClassHandler.test(ops: x.0, datas: x.1)

    let ans = sol.mostCommonWord(x.0, x.1)
    print(ans)

//    print(ans?.array() ?? [])
//    print(tmp)
}

struct ClassHandler {
    static func test(ops: [String], datas: [[Int]]) {
        let n = ops.count
        var sut = MyHashMap()
        let className = String(describing: sut).components(separatedBy: ".").last
        for i in 0..<n {
            let op = ops[i]
            let data = datas[i]
            switch op {
            case className:
                sut = MyHashMap()
                print("null")
            case "put":
                sut.put(data[0], data[1])
                print("null")
            case "get":
                print(sut.get(data[0]))
            case "remove":
                sut.remove(data[0])
            default:
                break
            }
        }
    }
}
