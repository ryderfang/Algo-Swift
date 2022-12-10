/*
 * @lc app=leetcode id=155 lang=swift
 *
 * [155] Min Stack
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class MinStack {
    // opt: 使用链表，每个节点保存当前的最小值
    private var stack: [Int]

    init() {
        stack = [Int]()
    }
    
    func push(_ val: Int) {
        stack.append(val)
    }
    
    func pop() {
        let last = stack.removeLast()
    }
    
    func top() -> Int {
        return stack.last ?? -1
    }
    
    func getMin() -> Int {
        return stack.min() ?? -1
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(val)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */
// @lc code=end

