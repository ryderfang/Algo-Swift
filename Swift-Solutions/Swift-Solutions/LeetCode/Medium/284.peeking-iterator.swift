/*
 * @lc app=leetcode id=284 lang=swift
 *
 * [284] Peeking Iterator
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
// Swift IndexingIterator refernence:
// https://developer.apple.com/documentation/swift/indexingiterator

class PeekingIterator {
    var arr: Array<Int>
    var idx: Int = 0

    init(_ arr: IndexingIterator<Array<Int>>) {
        self.arr = arr.map { $0 }
    }

    // move
    func next() -> Int {
        if hasNext() {
            idx += 1
            return arr[idx-1]
        }
        return -1
    }

    // not move
    func peek() -> Int {
        if hasNext() {
            return arr[idx]
        }
        return -1
    }
    
    func hasNext() -> Bool {
        idx < arr.count
    }
}

/**
 * Your PeekingIterator object will be instantiated and called as such:
 * let obj = PeekingIterator(arr)
 * let ret_1: Int = obj.next()
 * let ret_2: Int = obj.peek()
 * let ret_3: Bool = obj.hasNext()
 */
// @lc code=end

