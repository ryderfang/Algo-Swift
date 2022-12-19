/*
 * @lc app=leetcode id=705 lang=swift
 *
 * [705] Design HashSet
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class MyHashSet {
    private var nums: Set<Int>

    init() {
        nums = []
    }
    
    func add(_ key: Int) {
        nums.insert(key)
    }
    
    func remove(_ key: Int) {
        nums.remove(key)
    }
    
    func contains(_ key: Int) -> Bool {
        return nums.contains(key)
    }
}

/**
 * Your MyHashSet object will be instantiated and called as such:
 * let obj = MyHashSet()
 * obj.add(key)
 * obj.remove(key)
 * let ret_3: Bool = obj.contains(key)
 */
// @lc code=end

