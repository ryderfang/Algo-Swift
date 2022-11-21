//
//  HelperTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2022/11/21.
//

import XCTest

final class HelperTests: XCTestCase {

    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    // MARK - Int
    func testIsPrime() {
        XCTAssertTrue(2.isPrime())
        XCTAssertTrue(17.isPrime())
        XCTAssertTrue(67.isPrime())
        XCTAssertTrue(999983.isPrime())
    }

    func testDigitChar() {
        XCTAssertEqual(0.digitChar(), "0")
        XCTAssertEqual(3.digitChar(), "3")
        XCTAssertEqual(5.digitChar(), "5")
        XCTAssertEqual(9.digitChar(), "9")
        XCTAssertNil(12.digitChar())
    }

    func testAlphaChar() {
        XCTAssertEqual(97.alphaChar(), "a")
        XCTAssertEqual(121.alphaChar(), "y")
        XCTAssertEqual(66.alphaChar(), "B")
        XCTAssertEqual(88.alphaChar(), "X")
        XCTAssertNil(123.alphaChar())
    }
}
