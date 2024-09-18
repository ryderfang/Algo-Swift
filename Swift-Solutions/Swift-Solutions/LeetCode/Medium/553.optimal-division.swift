/*
 * @lc app=leetcode id=553 lang=swift
 *
 * [553] Optimal Division
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // Direct answer
    func optimalDivision2(_ nums: [Int]) -> String {
        let n = nums.count
        var ret = "\(nums[0])"
        guard n > 1 else { return ret }
        ret += "/"
        if n > 2 { ret += "(" }
        for i in 1..<n {
            if i > 1 {
                ret += "/"
            }
            ret += "\(nums[i])"
        }
        if n > 2 { ret += ")" }
        return ret
    }

    // Better solution: Divide & Conquer
    func optimalDivision(_ nums: [Int]) -> String {
        func _solve(_ nodes: [Double], _ findMax: Bool) -> _Node {
            let n = nodes.count
            guard n > 1 else { return .num(d: nodes[0]) }

            let exps = (1..<n)
                .map { i -> [[Double]] in [Array(nodes.prefix(i)), Array(nodes.suffix(n - i))] }
                .map { ns -> _Node in .exp(l: _solve(ns[0], findMax), r: _solve(ns[1], !findMax)) }
            let vals = exps.map { $0.val }
            let target = findMax ? vals.max()! : vals.min()!
            let ret = exps.first(where: { $0.val == target })!
            return ret
        }
        return "\(_solve(nums.map(Double.init), true))"
    }
}

private indirect enum _Node: CustomStringConvertible {
    case num(d: Double)
    case exp(l: _Node, r: _Node)

    var val: Double {
        switch self {
        case let .num(d): return d
        case let .exp(l, r): return l.val / r.val
        }
    }

    var description: String {
        switch self {
        case let .num(d):
            return "\(Int(d))"
        case let .exp(l, r): 
            let ls = "\(l)"
            var rs = "\(r)"
            if rs.contains("/") {
                rs = "(\(rs))"
            }
            return "\(ls)/\(rs)"
        }
    }
}
// @lc code=end

