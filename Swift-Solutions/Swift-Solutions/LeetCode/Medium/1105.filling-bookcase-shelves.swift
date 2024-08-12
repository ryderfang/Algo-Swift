/*
 * @lc app=leetcode id=1105 lang=swift
 *
 * [1105] Filling Bookcase Shelves
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

extension Solution {
    // n <- [1, 1000]
    func minHeightShelves(_ books: [[Int]], _ shelfWidth: Int) -> Int {
        let n = books.count
        guard n > 1 else { return books[0][1] }

        var bks = [Books]()
        for b in books {
            bks.append(Books(width: b[0], height: b[1]))
        }

        var dp = [Int](repeating: Int.max, count: n + 1)
        dp[0] = 0
        for i in 1...n {
            var (width, height) = (0, 0)
            for j in stride(from: i, to: 0, by: -1) {
                width += bks[j-1].width
                if width > shelfWidth {
                    break
                }
                height = max(height, bks[j-1].height)
                dp[i] = min(dp[i], dp[j-1] + height)
            }
        }

        return dp[n]
    }

    func minHeightShelves2(_ books: [[Int]], _ shelfWidth: Int) -> Int {
        let n = books.count
        guard n > 1 else { return books[0][1] }

        var bks = [Books]()
        for b in books {
            bks.append(Books(width: b[0], height: b[1]))
        }

        // i-th book add to j-th level
        var dp = [[Int]](repeating: [Int](repeating: Int.max, count: n), count: n)
        // left in level 0
        dp[0][0] = bks[0].height
        var lv0 = shelfWidth - bks[0].width
        for i in 1..<n {
            // level 0
            if lv0 >= bks[i].width {
                dp[i][0] = max(dp[i-1][0], bks[i].height)
                lv0 -= bks[i].width
            }
            for j in (1..<i).reversed() {
                // level j
                var tmpWidth = bks[i].width
                var maxHeight = bks[i].height
                // ...[k-1]  -> level j-1
                // [k]...i   -> level j
                for k in (j...i).reversed() {
                    if tmpWidth <= shelfWidth {
                        if dp[k-1][j-1] < Int.max {
                            dp[i][j] = min(dp[i][j], dp[k-1][j-1] + maxHeight)
                        }
                        tmpWidth += bks[k-1].width
                        maxHeight = max(maxHeight, bks[k-1].height)
                    } else {
                        break
                    }
                }
            }
            // level i
            dp[i][i] = dp[i-1][i-1] + bks[i].height
        }
        return dp[n-1].min() ?? 0
    }
}

private struct Books {
    var width: Int
    var height: Int
}
// @lc code=end
