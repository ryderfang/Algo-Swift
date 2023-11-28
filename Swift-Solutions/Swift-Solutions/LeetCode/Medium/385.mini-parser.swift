/*
 * @lc app=leetcode id=385 lang=swift
 *
 * [385] Mini Parser
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#else
class NestedInteger {
    public func isInteger() -> Bool { false }
    public func getInteger() -> Int { 1 }
    public func setInteger(_ value: Int) { }
    public func add(_ elem: NestedInteger) { }
    public func getList() -> [NestedInteger] { [] }
}
#endif
/**
 * // This is the interface that allows for creating nested lists.
 * // You should not implement it, or speculate about its implementation
 * class NestedInteger {
 *     // Return true if this NestedInteger holds a single integer, rather than a nested list.
 *     public func isInteger() -> Bool
 *
 *     // Return the single integer that this NestedInteger holds, if it holds a single integer
 *     // The result is undefined if this NestedInteger holds a nested list
 *     public func getInteger() -> Int
 *
 *     // Set this NestedInteger to hold a single integer.
 *     public func setInteger(value: Int)
 *
 *     // Set this NestedInteger to hold a nested list and adds a nested integer to it.
 *     public func add(elem: NestedInteger)
 *
 *     // Return the nested list that this NestedInteger holds, if it holds a nested list
 *     // The result is undefined if this NestedInteger holds a single integer
 *     public func getList() -> [NestedInteger]
 * }
 */
extension Solution {
    func deserialize(_ s: String) -> NestedInteger {
        let arr = [Character](s)
        let n = arr.count
        var stack = [NestedInteger]()
        var i = 0
        while i < n {
            switch arr[i] {
            case "[":
                let nval = NestedInteger()
                stack.append(nval)
                i += 1
                break
            case ",":
                let last = stack.removeLast()
                if let llast = stack.last {
                    llast.add(last)
                }
                i += 1
                break
            case "]":
                if arr[i-1] != "[" {
                    let last = stack.removeLast()
                    if let llast = stack.last {
                        llast.add(last)
                    }
                } else {
                    // empty list
                }
                i += 1
                break
                // "-" || isAlpha()
            default:
                let ival = NestedInteger()
                var tmp = [Character]()
                while i < n && !["[","]",","].contains(arr[i]) {
                    tmp.append(arr[i])
                    i += 1
                }
                let iv = Int(tmp.map({String($0)}).joined())!
                ival.setInteger(iv)
                stack.append(ival)
                break
            }
        }
        return stack.first!
    }
}
// @lc code=end

