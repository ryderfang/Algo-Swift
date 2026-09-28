/*
 * @lc app=leetcode id=378 lang=swift
 *
 * [378] Kth Smallest Element in a Sorted Matrix
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif

// MARK: Better Solution - Binary Search
extension Solution {
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count

        func _countSmaller(_ a: Int) -> Int {
            var (i, j) = (0, n - 1)
            var count = 0
            while i < n && j >= 0 {
                if matrix[i][j] <= a {
                    count += (j + 1)
                    i += 1
                } else {
                    j -= 1
                }
            }
            return count
        }

        var (left, right) = (matrix[0][0], matrix[n-1][n-1])
        while left < right {
            let mid = left + (right - left) / 2
            let count = _countSmaller(mid)
            if count < k {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left
    }
}

// MARK: Solution1 - Divide and Conquer
// http://www.cse.yorku.ca/~andy/pubs/X+Y.pdf
extension Solution {
    func kthSmallest1(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        guard k >= 1 && k <= n * n else { return -1 }
        let start = max(k - n * n + n  - 1, 0)
        let k = k - n * n + (n - start) * (n - start)
//        let start = 0
        let (result, _) = _biselect1(Array(start..<min(n, start + k)), matrix, k, k)
        return result
    }

    func _biselect1(_ index: [Int], _ mat: [[Int]], _ k1: Int, _ k2: Int) -> (Int, Int) {
        let n = index.count
        let isEven = (n % 2 == 0)
        let A: (Int, Int) -> Int = { (_ i: Int, _ j: Int) in
            mat[index[i]][index[j]]
        }
        if n <= 2 {
            var nums = [Int]()
            for i in 0..<n {
                for j in 0..<n {
                    nums.append(A(i, j))
                }
            }
            nums.sort()
            return (nums[k1-1], nums[k2-1])
        }

        // sub problem
        // [0,1,2...] -> [0,2,...(n-1)]
        var index_ = [Int]()
        for i in stride(from: 0, to: n, by: 2) {
            index_.append(index[i])
        }
        if isEven {
            index_.append(index[n-1])
        }
        let k1_ = isEven ? (n + 1 + (k1 + 3) / 4) : ((k1 + 2 * n) / 4 + 1)
        let k2_ = (k2 + 3) / 4
        let (a, b) = _biselect1(index_, mat, k1_, k2_)

        // calc
        var (ra_less, rb_more) = (0, 0)
        var L = [Int]()
        // ja - first element larger or equal to a
        // jb - first element larger than b
        var (jb, ja) = (n, n)
        for i in 0..<n {
            while jb > 0 && A(i, jb-1) > b {
                jb -= 1
            }
            while ja > 0 && A(i, ja-1) >= a {
                ja -= 1
            }
            ra_less += ja
            rb_more += (n - jb)
            if ja > jb {
                L += (jb..<ja).map { A(i, $0) }
            }
        }
        var (x, y) = (0, 0)
        if ra_less <= k1 - 1 {
            x = a
        } else if k1 + rb_more - n * n <= 0 {
            x = b
        } else {
            x = _pick(L, k1 + rb_more - n * n)
        }
        if ra_less <= k2 - 1 {
            y = a
        } else if k2 + rb_more - n * n <= 0 {
            y = b
        } else {
            y = _pick(L, k2 + rb_more - n * n)
        }
        return (x, y)
    }

    // O(len(L)) - kth element of list
    // median of medians algorithm
    func _pick(_ list: [Int], _ k: Int) -> Int {
        let n = list.count
//        return list.sorted()[k-1]
        assert(n > 0)
        if k == 1 {
            return list.min()!
        }
        var groups = [[Int]]()
        var medians = [Int]()
        for i in stride(from: 0, to: n, by: 5) {
            let g = Array(list[i..<min(i+5,n)]).sorted()
            groups.append(g)
            medians.append(g[g.count / 2])
        }
        let pivot = _pick(medians, medians.count / 2 + 1)
        var less = [Int]()
        var equal = [Int]()
        var greater = [Int]()
        for x in list {
            if x > pivot {
                greater.append(x)
            } else if x < pivot {
                less.append(x)
            } else {
                equal.append(x)
            }
        }
        if k <= less.count {
            return _pick(less, k)
        }
        let k_ = k - less.count - equal.count
        if k_ < 1 {
            return pivot
        } else {
            return _pick(greater, k_)
        }
    }
}

// MARK: Solution2 - Divide and Conquer
// https://chaoxu.prof/posts/2014-04-02-selection-in-a-sorted-matrix.html
extension Solution {
    // X + Y 问题 (http://www.cse.yorku.ca/~andy/pubs/X+Y.pdf)
    func kthSmallest2(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        let m = matrix[0].count
        guard k >= 1 && k <= n * m else { return -1 }

        let (result, _) = _biselect(k-1, k-1, matrix)
        return result
    }

    func _biselect(_ lb: Int, _ ub: Int, _ mat: [[Int]]) -> (Int, Int) {
        let n = mat.count
        let m = mat[0].count
        if n > m {
            return _biselect(lb, ub, mat.transposed())
        }
        var (a, b) = (mat[0][0], mat[n-1][m-1])
        if n >= 3 {
            let hm = m / 2 + 1
            let _lb = lb / 2
            let _ub = min(ub / 2 + n, n * hm - 1)
            let halfMat = mat.halfMat()
            (a, b) = _biselect(_lb, _ub, halfMat)
        }
        let ra = _rankInMatrix(mat, a: a)
        let values = _selectRange(mat, a: a, b: b)
        return (values[lb-ra], values[ub-ra])
    }

    // O(n): top-left region bound of index pairs, matrix[i][j] <= b
    func _frontier(_ mat: [[Int]], _ b: Int) -> [(Int, Int)] {
        var result: [(Int, Int)] = []
        let n = mat.count
        let m = mat[0].count
        var i = 0
        var j = m - 1
        while i <= n - 1 && j >= 0 {
            if mat[i][j] <= b {
                result.append((i, j))
                i += 1
            } else {
                j -= 1
            }
        }
        return result
    }

    // O(n): the rank of an element in the matrix
    func _rankInMatrix(_ mat: [[Int]], a: Int) -> Int {
        let n = mat.count
        let m = mat[0].count
        var i = 0
        var j = m - 1
        var rank = 0
        while i <= n - 1 && j >= 0 {
            if mat[i][j] < a {
                rank += (j + 1)
                i += 1
            } else {
                j -= 1
            }
        }
        return rank
    }

    // O(n): select all elements x in the matrix such that a <= x <= b
    func _selectRange(_ mat: [[Int]], a: Int, b: Int) -> [Int] {
        var result: [Int] = []
        for (x, y) in _frontier(mat, b) {
            for j in (0...y).reversed() {
                if mat[x][j] >= a {
                    result.append(mat[x][j])
                } else {
                    break
                }
            }
        }
        return result.sorted()
    }
}

extension Array where Element == [Int] {
    // 矩阵转置
    func transposed() -> [[Int]] {
        guard let firstRow = self.first else { return [] }
        return firstRow.indices.map { index in
            self.map { $0[index] }
        }
    }

    // Let A' be the matrix we get by removing all even index (1-indexed) columns from A,
    // and add the last column.
    func halfMat() -> [[Int]] {
        guard let firstRow = self.first else { return [] }
        let n = self.count
        let m = firstRow.count
        let hm = m / 2 + 1
        var ret = [[Int]](repeating: [Int](repeating: 0, count: hm), count: n)
        let isEven = (m % 2 == 0)
        for i in 0..<n {
            for j in 0..<hm {
                if j == hm - 1 {
                    ret[i][j] = isEven ? self[i][j * 2 - 1] : self[i][2 * j]
                } else {
                    ret[i][j] = self[i][j * 2]
                }
            }
        }
        return ret
    }
}

// MARK: Solution3 - Priority Queue
// O(klogn) / O(k)
extension Solution {
    func kthSmallest3(_ matrix: [[Int]], _ k: Int) -> Int {
        let n = matrix.count
        typealias Pair = (i: Int, j: Int, v: Int)
        var pq = PriorityQueue<Pair>([], { $0.v < $1.v })
        for j in 0..<n {
            pq.enqueue((i: 0, j: j, v: matrix[0][j]))
        }
        var cnt = 0
        var ans = 0
        while cnt < k {
            guard let last = pq.dequeue() else { break }
            if last.i < n - 1 {
                pq.enqueue((i: last.i + 1, j: last.j, v: matrix[last.i+1][last.j]))
            }
            ans = last.v
            cnt += 1
        }
        return ans
    }
}

fileprivate struct PriorityQueue<Element> {
    private var elements = [Element]()
    private let hasHigherPriority: (Element, Element) -> Bool
    var isEmpty: Bool { elements.count == 0 }
    var front: Element? { elements.first }

    init(_ array: [Element], _ sort: @escaping (Element, Element) -> Bool) {
        self.hasHigherPriority = sort
        for x in array {
            self.enqueue(x)
        }
    }

    mutating func enqueue(_ element: Element) {
        elements.append(element)
        bubbleToHigherPriority(elements.count - 1)
    }

    @discardableResult
    mutating func dequeue() -> Element? {
        guard let front = front else { return nil }
        removeAt(0)
        return front
    }

    private mutating func removeAt(_ index: Int) {
        let removingLast = index == elements.count - 1
        if !removingLast {
            elements.swapAt(index, elements.count - 1)
        }
        _ = elements.popLast()
        if !removingLast {
            bubbleToHigherPriority(index)
            bubbleToLowerPriority(index)
        }
    }

    private mutating func bubbleToHigherPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < elements.count)

        var unbalancedIndex = initialUnbalancedIndex
        while unbalancedIndex > 0 {
            let parentIndex = (unbalancedIndex - 1) / 2
            guard self.hasHigherPriority(elements[unbalancedIndex], elements[parentIndex]) else { break }
            elements.swapAt(unbalancedIndex, parentIndex)
            unbalancedIndex = parentIndex
        }
    }

    private mutating func bubbleToLowerPriority(_ initialUnbalancedIndex: Int) {
        precondition(initialUnbalancedIndex >= 0)
        precondition(initialUnbalancedIndex < elements.count)

        var unbalancedIndex = initialUnbalancedIndex
        while true {
            let leftChildIndex = unbalancedIndex * 2 + 1
            let rightChildIndex = unbalancedIndex * 2 + 2
            var highestPriorityIndex = unbalancedIndex
            if leftChildIndex < elements.count && self.hasHigherPriority(elements[leftChildIndex], elements[highestPriorityIndex]) {
                highestPriorityIndex = leftChildIndex
            }
            if rightChildIndex < elements.count && self.hasHigherPriority(elements[rightChildIndex], elements[highestPriorityIndex]) {
                highestPriorityIndex = rightChildIndex
            }
            guard highestPriorityIndex != unbalancedIndex else { break }
            elements.swapAt(highestPriorityIndex, unbalancedIndex)
            unbalancedIndex = highestPriorityIndex
        }
    }
}

// @lc code=end
