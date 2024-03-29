//
//  SortTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2024/2/7.
//

import XCTest
@testable import AlgoBase

final class SortTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: O(n^2)
    func testBubbleSort() {
        var nums = [1, 8, 4, 2, 11, 2, 7, 3]
        Sort.bubbleSort(&nums)
        XCTAssertEqual(nums, [1, 2, 2, 3, 4, 7, 8, 11])
    }
    

    // MARK: O(n*logn)

    // MARK: O(n)

    func testQuickSort() {
        var nums = [1, 8, 4, 2, 11, 2, 7, 3]
        Sort.quickSort(&nums)
        XCTAssertEqual(nums, [1, 2, 2, 3, 4, 7, 8, 11])
    }

    func testInsectionSort() {
        var nums = [1, 8, 4, 2, 11, 2, 7, 3]
        Sort.insertionSort(&nums)
        XCTAssertEqual(nums, [1, 2, 2, 3, 4, 7, 8, 11])
    }

    func testShellSort() {
        var nums = [1, 8, 4, 2, 11, 2, 7, 3]
        Sort.shellSort(&nums)
        XCTAssertEqual(nums, [1, 2, 2, 3, 4, 7, 8, 11])
    }

}
