/*
 * @lc app=leetcode id=232 lang=swift
 *
 * [232] Implement Queue using Stacks
 */

// @lc code=start

class MyQueue {
    fileprivate var stack: [Int]

    init() {
       stack = [Int]()
    }
    
    func push(_ x: Int) {
        stack.append(x)
    }
    
    func pop() -> Int {
        if !empty() {
            return stack.removeFirst()
        } else {
            return -1
        }
    }
    
    func peek() -> Int {
        if !empty() {
            return stack.first!
        } else {
            return -1
        }
    }
    
    func empty() -> Bool {
        return stack.isEmpty
    }
}

/**
 * Your MyQueue object will be instantiated and called as such:
 * let obj = MyQueue()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.peek()
 * let ret_4: Bool = obj.empty()
 */
// @lc code=end

