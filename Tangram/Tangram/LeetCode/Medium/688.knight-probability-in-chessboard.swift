/*
 * @lc app=leetcode id=688 lang=swift
 *
 * [688] Knight Probability in Chessboard
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    func knightProbability(_ n: Int, _ k: Int, _ row: Int, _ column: Int) -> Double {
        var cached = [HashableTriple<Int, Int, Int>: Double]()
        func _solve(_ i: Int, _ j: Int, _ k: Int) -> Double {
            guard i >= 0 && i < n && j >= 0 && j < n else { return 0.0 }
            guard k > 0 else { return 1.0 }
            if let cache = cached[HashableTriple((i, j, k))] {
                return cache
            }
            var tmp = _solve(i - 2, j - 1, k - 1) + _solve(i - 2, j + 1, k - 1)
            + _solve(i - 1, j - 2, k - 1) + _solve(i - 1, j + 2, k - 1)
            + _solve(i + 1, j - 2, k - 1) + _solve(i + 1, j + 2, k - 1)
            + _solve(i + 2, j - 1, k - 1) + _solve(i + 2, j + 1, k - 1)
            tmp /= 8.0
            cached[HashableTriple((i, j, k))] = tmp
            return tmp
        }
        return _solve(row, column, k)
    }
}

private struct HashableTriple<T1: Hashable, T2: Hashable, T3: Hashable>: Hashable {
    let first: T1
    let second: T2
    let third: T3
    
    init(_ values: (T1, T2, T3)) {
        self.first = values.0
        self.second = values.1
        self.third = values.2
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(first)
        hasher.combine(second)
        hasher.combine(third)
    }

    static func == (lhs: HashableTriple, rhs: HashableTriple) -> Bool {
        return lhs.first == rhs.first && lhs.second == rhs.second && lhs.third == rhs.third
    }
}

// @lc code=end

