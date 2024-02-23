//
//  BITTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2024/2/23.
//

import XCTest
@testable import AlgoBase

final class BITTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testBIT() {
        var nums = [1,2,3,4,5,6]
        let bit = BinaryIndexTree(nums)
        XCTAssertEqual(bit.query(5), 21)
        XCTAssertEqual(bit.query(3, 5), 15)
        bit.add(2, 10)
        XCTAssertEqual(bit.query(0, 2),  16)
        bit.update(0, 3)
        XCTAssertEqual(bit.query(1), 5)
        XCTAssertEqual(bit.suffix(0), 33)

        nums = [-10, -1, 3, 1, 9, 2, 100, 1]
        XCTAssertEqual(BinaryIndexTree.leftLessCounts(nums, 5), 3)
    }

    func testBITEx() {
        let bit = BinaryIndexTreeEx(10)
        bit.add(0, 3, 1)
        bit.add(2, 5, 2)
        bit.add(3, 4, 6)
        XCTAssertEqual(bit.query(2), 3)
        XCTAssertEqual(bit.query(3), 9)
    }

    func testST() {
        let nums = [1,2,3,4,5,6]
        let st = SegmentTree(nums)
        XCTAssertEqual(st.query(5), 21)
        XCTAssertEqual(st.query(3, 5), 15)
        st.add(2, 10)
        XCTAssertEqual(st.query(0, 2),  16)
        st.update(0, 3)
        XCTAssertEqual(st.query(1), 5)
        XCTAssertEqual(st.suffix(0), 33)
    }
}
