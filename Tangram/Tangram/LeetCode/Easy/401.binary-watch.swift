/*
 * @lc app=leetcode id=401 lang=swift
 *
 * [401] Binary Watch
 */

// @lc code=start
extension Solution {
    func readBinaryWatch(_ turnedOn: Int) -> [String] {
        guard turnedOn > 0 else { return ["0:00"] }
        if turnedOn >= 9 {
            return []
        }
        func getTime(_ led: [Int], _ turnedOn: Int, _ limit: Int) -> [Int] {
            guard turnedOn > 0 else { return [0] }
            guard led.count > 0 else { return [] }
            let first = led[0]
            let dropFirst = [Int](led.dropFirst())
            var ans = [Int]()
            let pick = getTime(dropFirst, turnedOn - 1, limit)
            ans.append(contentsOf: pick.map{ first + $0 }.filter{ $0 <= limit})
            let noPick = getTime(dropFirst, turnedOn, limit)
            ans.append(contentsOf: noPick.filter { $0 <= limit })
            return ans
        }
        var ans = [String]()
        for i in 0...turnedOn {
            let hours = getTime([8, 4, 2, 1], i, 11)
            let minutes = getTime([32, 16, 8, 4, 2, 1], turnedOn - i, 59)
            for h in hours {
                for m in minutes {
                    let mStr = m < 10 ? "0\(m)" : "\(m)"
                    ans.append("\(h):" + mStr)
                }
            }
        }
        return ans
    }
}
// @lc code=end

