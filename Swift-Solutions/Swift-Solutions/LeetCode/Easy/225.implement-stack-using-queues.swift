/*
 * @lc app=leetcode id=225 lang=swift
 *
 * [225] Implement Stack using Queues
 */

// @lc code=start

class MyStack {
    fileprivate var queue: [Int]

    init() {
        queue = [Int]()
    }
    
    func push(_ x: Int) {
        queue.append(x)
    }
    
    func pop() -> Int {
        if !empty() {
            return queue.removeLast()
        }
        return -1
    }
    
    func top() -> Int {
        guard let top = queue.last else { return -1 }
        return top
    }
    
    func empty() -> Bool {
        return queue.isEmpty
    }
}

/**
 * Your MyStack object will be instantiated and called as such:
 * let obj = MyStack()
 * obj.push(x)
 * let ret_2: Int = obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Bool = obj.empty()
 */
// @lc code=end

