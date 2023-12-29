/*
 * @lc app=leetcode id=858 lang=swift
 *
 * [858] Mirror Reflection
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    /*
     2     1
     |\    |
     | \   |
     |  \  |
     |   \ |
     |    /|
     |   / |
     |  /  |
     | /   |
     x-----0

     if height is infinity, increase q one time
    */
    func mirrorReflection(_ p: Int, _ q: Int) -> Int {
        var verticalDist = 0
        for i in 1...Int.max {
            verticalDist += q
            if verticalDist % p == 0 {
                if i % 2 == 0 {
                    return 2
                } else if (verticalDist / p) % 2 == 0 {
                    return 0
                } else {
                    return 1
                }
            }
        }
        // invalid
        return -1
    }

    /*
     2-----1
     |     |
     |     |
     x-----0
    */
    func mirrorReflection1(_ p: Int, _ q: Int) -> Int {
        var p = p, q = q
        // Guessed the pattern
        while p % 2 == 0 && q % 2 == 0 {
            p /= 2
            q /= 2
        }
        // 3/2, 5/2, 5/4 
        if p % 2 == 1 && q % 2 == 0 {
            return 0
        }
        // 3/1, 5/3
        if p % 2 == 1 && q % 2 == 1 {
            return 1
        }
        // 4/3, 2/1, 4/1
        if p % 2 == 0 && q % 2 == 1 {
            return 2
        }
        return -1
    }
}
// @lc code=end
