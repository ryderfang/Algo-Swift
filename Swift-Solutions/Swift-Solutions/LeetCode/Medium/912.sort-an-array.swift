/*
 * @lc app=leetcode id=912 lang=swift
 *
 * [912] Sort an Array
 */

// @lc code=start
#if !LC_SOLUTION_EXT
class Solution {}
#endif
extension Solution {
    // n <- [1, 5*1e4]
    // nums[i] -> [-5*1e4, 5*1e4]
    func sortArray(_ nums: [Int]) -> [Int] {
        // O(n)
//        _bucketSort(nums)
//        _radixSort(nums)
//        _countingSort(nums)

        // O(nlogn)
        _heapSort(nums)
//        _mergeSort(nums)
//        _quickSort(nums)
//        _shellSort(nums)

        // O(n^2)
//        _bubbleSort(nums) // TLE
//        _insertionSort(nums) // 3s - AC
//        _selectionSort(nums) // TLE
    }

    // MARK: - O(n)
    func _bucketSort(_ nums: [Int]) -> [Int] {
        let maxSize = Int(1e5 + 1)
        var bucket = [Int](repeating: 0, count: maxSize)
        let offSet = Int(5 * 1e4)
        let nums = nums.map { $0 + offSet }
        for x in nums {
            bucket[x] += 1
        }
        var ans = [Int]()
        for (x, c) in bucket.enumerated() {
            ans.append(contentsOf: [Int](repeating: x, count: c))
        }
        return ans.map { $0 - offSet }
    }

    func _radixSort(_ nums: [Int]) -> [Int] {
        let offSet = Int(5 * 1e4)
        var nums = nums.map { $0 + offSet }
        let radix = 10
        var done = false
        var digit = 1
        while !done {
            done = true
            var buckets: [[Int]] = []
            for _ in 1...radix {
                buckets.append([])
            }
            for x in nums {
                let index = x / digit
                buckets[index % radix].append(x)
                if done && index > 0 {
                    done = false
                }
            }

            var i = 0
            for j in 0..<radix {
                let bucket = buckets[j]
                for x in bucket {
                    nums[i] = x
                    i += 1
                }
            }

            digit *= radix
        }
        return nums.map { $0 - offSet }
    }

    func _countingSort(_ nums: [Int]) -> [Int] {
        let n = nums.count
        guard n > 0 else { return [] }
        let maxElement = nums.max()!
        let minElement = nums.min()!
        let offSet = minElement < 0 ? -minElement : 0
        var countArray = [Int](repeating: 0, count: maxElement + offSet + 1)
        for ele in nums {
            countArray[ele + offSet] += 1
        }
        for i in 1..<countArray.count {
            countArray[i] += countArray[i-1]
        }
        var sortedArray = [Int](repeating: 0, count: n)
        for i in stride(from: n - 1, through: 0, by: -1) {
            let ele = nums[i]
            countArray[ele + offSet] -= 1
            sortedArray[countArray[ele + offSet]] = ele
        }
        return sortedArray
    }

    // MARK: - O(nlogn)
    func _heapSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        func _heapIfy(_ nums: inout [Int], _ n: Int, _ i: Int) {
            let l = 2 * i + 1
            let r = 2 * i + 2
            var largest = i
            if l < n && nums[largest] < nums[l] {
                largest = l
            }
            if r < n && nums[largest] < nums[r] {
                largest = r
            }
            if largest != i {
                nums.swapAt(largest, i)
                _heapIfy(&nums, n, largest)
            }
        }
        let n = nums.count
        // build maxHeap
        for i in stride(from: n / 2, through: 0, by: -1) {
            _heapIfy(&nums, n, i)
        }
        for i in stride(from: n - 1, through: 0, by: -1) {
            // 最大值移动到最后
            nums.swapAt(i, 0)
            _heapIfy(&nums, i, 0)
        }
        return nums
    }

    func _mergeSort(_ nums: [Int]) -> [Int] {
        // merge two sorted array
        func _merge(_ leftPile: [Int], _ rightPile: [Int]) -> [Int] {
            var (leftIndex, rightIndex) = (0, 0)
            var orderedPile = [Int]()
            orderedPile.reserveCapacity(leftPile.count + rightPile.count)
            while true {
                guard leftIndex < leftPile.endIndex else {
                    orderedPile.append(contentsOf: rightPile[rightIndex..<rightPile.endIndex])
                    break
                }
                guard rightIndex < rightPile.endIndex else {
                    orderedPile.append(contentsOf: leftPile[leftIndex..<leftPile.endIndex])
                    break
                }
                if leftPile[leftIndex] < rightPile[rightIndex] {
                    orderedPile.append(leftPile[leftIndex])
                    leftIndex += 1
                } else {
                    orderedPile.append(rightPile[rightIndex])
                    rightIndex += 1
                }
            }
            return orderedPile
        }
        let n = nums.count
        guard n > 1 else { return nums }
        let mid = n / 2
        let leftArray = sortArray(Array(nums[0..<mid]))
        let rightArray = sortArray(Array(nums[mid..<n]))
        return _merge(leftArray, rightArray)
    }

    func _quickSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        func _qSort(_ beg: Int, _ end: Int, _ nums: inout [Int]) {
            var i = beg, j = end, x = nums[(beg + end) / 2]
            while true {
                while nums[i] < x { i += 1 }
                while nums[j] > x { j -= 1 }
                if i <= j {
                    nums.swapAt(i, j)
                    i += 1
                    j -= 1
                }
                guard i < j else { break }
            }
            if i < end {
                _qSort(i, end, &nums)
            }
            if j > beg {
                _qSort(beg, j, &nums)
            }
        }
        _qSort(0, nums.count - 1, &nums)
        return nums
    }

    func _shellSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        var step = nums.count / 2
        while step > 0 {
            for i in 0..<step {
                _insertionSort(&nums, start: i, gap: step)
            }
            step /= 2
        }
        return nums
    }

    // MARK: - O(n^2)
    func _bubbleSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        let n = nums.count
        for i in 0..<n {
            for j in 1..<n-i {
                if nums[j] < nums[j-1] {
                    nums.swapAt(j, j-1)
                }
            }
        }
        return nums
    }

    func _insertionSort(_ nums: inout [Int], start: Int, gap: Int) {
        let n = nums.count
        for i in stride(from: start + gap, to: n, by: gap) {
            let key = nums[i]
            var pos = i
            while pos >= gap && nums[pos-gap] > key {
                nums[pos] = nums[pos-gap]
                pos -= gap
            }
            nums[pos] = key
        }
    }

    func _insertionSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        _insertionSort(&nums, start: 0, gap: 1)
        return nums
    }

    func _selectionSort(_ nums: [Int]) -> [Int] {
        var nums = nums
        let n = nums.count
        for i in 0..<n-1 {
            var lowest = i
            for j in i+1..<n {
                if nums[j] < nums[lowest] {
                    lowest = j
                }
            }
            nums.swapAt(i, lowest)
        }
        return nums
    }
}
// @lc code=end
