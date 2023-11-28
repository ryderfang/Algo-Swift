/*
 * @lc app=leetcode id=341 lang=swift
 *
 * [341] Flatten Nested List Iterator
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#else
//class NestedInteger {
//    public func isInteger() -> Bool { false }
//    public func getInteger() -> Int { 1 }
//    public func setInteger(value: Int) { }
//    public func add(elem: NestedInteger) { }
//    public func getList() -> [NestedInteger] { [] }
//}
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
class NestedIterator {
    var nestedList: [NestedInteger]
    var flattedArray: [Int]
    var index: Int = 0
    var n: Int = 0

    init(_ nestedList: [NestedInteger]) {
        self.nestedList = nestedList
        flattedArray = [Int]()
        for ni in nestedList {
            flattedArray.append(contentsOf: flatted(ni))
        }
        n = flattedArray.count
    }

    private func flatted(_ ni: NestedInteger) -> [Int] {
        if ni.isInteger() {
            return [ni.getInteger()]
        }
        let childs = ni.getList()
        var ans = [Int]()
        for c in childs {
            ans.append(contentsOf: flatted(c))
        }
        return ans
    }
    
    func next() -> Int {
        let ret = flattedArray[index]
        index += 1
        return ret
    }
    
    func hasNext() -> Bool {
        index < n
    }
}

/**
 * Your NestedIterator object will be instantiated and called as such:
 * let obj = NestedIterator(nestedList)
 * let ret_1: Int = obj.next()
 * let ret_2: Bool = obj.hasNext()
 */
// @lc code=end

