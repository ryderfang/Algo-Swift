/*
 * @lc app=leetcode id=706 lang=swift
 *
 * [706] Design HashMap
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class MyHashMap {
    private var mp: [Int: Int]
    init() {
        mp = [Int: Int]()
    }
    
    func put(_ key: Int, _ value: Int) {
       mp[key] = value
    }
    
    func get(_ key: Int) -> Int {
        return mp[key] ?? -1
    }
    
    func remove(_ key: Int) {
        mp.removeValue(forKey: key)
    }
}

/**
 * Your MyHashMap object will be instantiated and called as such:
 * let obj = MyHashMap()
 * obj.put(key, value)
 * let ret_2: Int = obj.get(key)
 * obj.remove(key)
 */
// @lc code=end

