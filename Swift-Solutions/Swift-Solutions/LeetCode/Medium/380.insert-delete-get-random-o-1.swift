/*
 * @lc app=leetcode id=380 lang=swift
 *
 * [380] Insert Delete GetRandom O(1)
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

// Better solution: hashmap(val: index) + arr
// remove <- swap value index and last

class RandomizedSet {
    var st: Set<Int>

    init() {
        st = Set<Int>()
    }
    
    func insert(_ val: Int) -> Bool {
        if st.contains(val) {
            return false
        } else {
            st.insert(val)
            return true
        }
    }
    
    func remove(_ val: Int) -> Bool {
        if st.contains(val) {
            st.remove(val)
            return true
        } else {
            return false
        }
    }
    
    func getRandom() -> Int {
        let rand = Int.random(in: 0..<st.count)
        let arr = [Int](st)
        return arr[Int(rand)]
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * let obj = RandomizedSet()
 * let ret_1: Bool = obj.insert(val)
 * let ret_2: Bool = obj.remove(val)
 * let ret_3: Int = obj.getRandom()
 */
// @lc code=end

