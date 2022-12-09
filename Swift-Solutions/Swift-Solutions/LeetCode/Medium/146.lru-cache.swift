/*
 * @lc app=leetcode id=146 lang=swift
 *
 * [146] LRU Cache
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

class LRUCache {
    private var cache: [Int: Int]
    private var keys: [Int]
    private var count: Int = 0
    private var capacity: Int

    init(_ capacity: Int) {
        self.cache = [Int: Int]()
        self.keys = [Int]()
        self.capacity = capacity
    }
    
    func get(_ key: Int) -> Int {
        if let value = cache[key] {
            put(key, value)
            return value
        }
        return -1
    }
    
    func put(_ key: Int, _ value: Int) {
        // exists
        if let _ = cache[key] {
            cache[key] = value
            keys.removeAll(where: { $0 == key })
            keys.append(key)
            return
        }
        if count >= capacity {
            // least recently used key
            let lruk = keys.removeFirst()
            cache.removeValue(forKey: lruk)
            count -= 1
        }

        keys.append(key)
        count += 1
        cache[key] = value
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * let obj = LRUCache(capacity)
 * let ret_1: Int = obj.get(key)
 * obj.put(key, value)
 */
// @lc code=end

