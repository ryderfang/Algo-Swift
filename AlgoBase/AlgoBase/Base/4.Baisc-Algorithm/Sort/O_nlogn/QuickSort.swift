//
//  QuickSort.swift
//  AlgoBase
//
//  Created by Ryder on 2022/10/28.
//

import Foundation

// 排序测试: lc912
class Sort {}

// 快速排序（不稳定）
// In-place
// 时间：O(nlogn)
// 空间：O(logn)
extension Sort {
    static func quickSort(_ nums: inout [Int]) {
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
    }
}

// 将数组分成三段，小于 | 等于 | 大于，段内不一定有序
// Dutch National Flag (DNF problem)
// -> 🇳🇱
extension Sort {
    func partitionDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int, pivotIndex: Int) -> (Int, Int) {
      let pivot = a[pivotIndex]

      var smaller = low
      var equal = low
      var larger = high

      // This loop partitions the array into four (possibly empty) regions:
      //   [low    ...smaller-1] contains all values < pivot,
      //   [smaller...  equal-1] contains all values == pivot,
      //   [equal  ...   larger] contains all values > pivot,
      //   [larger ...     high] are values we haven't looked at yet.
      while equal <= larger {
        if a[equal] < pivot {
          swap(&a, smaller, equal)
          smaller += 1
          equal += 1
        } else if a[equal] == pivot {
          equal += 1
        } else {
          swap(&a, equal, larger)
          larger -= 1
        }
      }
      return (smaller, larger)
    }

    func quicksortDutchFlag<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
      if low < high {
        let pivotIndex = random(min: low, max: high)
        let (p, q) = partitionDutchFlag(&a, low: low, high: high, pivotIndex: pivotIndex)
        quicksortDutchFlag(&a, low: low, high: p - 1)
        quicksortDutchFlag(&a, low: q + 1, high: high)
      }
    }

    public func random(min: Int, max: Int) -> Int {
      assert(min < max)
      return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }

    public func swap<T>(_ a: inout [T], _ i: Int, _ j: Int) {
      if i != j {
        a.swapAt(i, j)
      }
    }
}
