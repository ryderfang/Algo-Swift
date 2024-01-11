//
//  GeometryTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2023/12/20.
//

import XCTest
@testable import AlgoBase

final class GeometryTests: XCTestCase {
    let sut = Geometry()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPoints() {
        let (p1, p2, p3) = (Point([0, 0]), Point([1, 2]), Point([2, 4]))
        XCTAssertTrue(sut.dotsInLine(p1, p2, p3))
        XCTAssertEqual(sut.distance(p1, p2), sut.distance(p2, p3))
        XCTAssertEqual(sut.distance(p1.x, p1.y, p2.x, p2.y), sqrt(5.0))
    }

    func testLine() {
        let (p1, p2) = ([0.0, 0.0], [2.0, 4.0])
        let p = [1.0, 2.0]
        XCTAssertTrue(sut.dotOnLine(p[0], p[1], p1[0], p1[1], p2[0], p2[1]))
        XCTAssertTrue(sut.dotOnLine(p1[0], p1[1], p1[0], p1[1], p2[0], p2[1]))
        XCTAssertFalse(sut.dotOnLineEx(p1[0], p1[1], p1[0], p1[1], p2[0], p2[1]))

        let line = sut.lineOfDots(0, 1, 1, 3)
        XCTAssertEqual(line.0, 2.0)
        XCTAssertEqual(line.1, 1.0)
    }

    func testTriangle() {
        let (p0, p1, p2) = ([0.0, 0.0], [0.0, 4.0], [3.0, 0.0])
        XCTAssertEqual(sut.triArea(p0[0], p0[1], p1[0], p1[1], p2[0], p2[1]), 6.0)
        XCTAssertEqual(sut.triArea(3.0, 4.0, 5.0), 6.0)
    }

    func testTriangleCenters() {
        let sut = Geometry()
        let (a, b, c) = (Point(2, 3), Point(9, 1), Point(5, 7))
        XCTAssertEqual(sut.triArea(sut.distance(a, b), sut.distance(b, c), sut.distance(c, a)),
                       sut.triArea(a.x, a.y, b.x, b.y, c.x, c.y))
        let fermet = sut.fermetPoint(Point([3, 3]), Point([9, 1]), Point([5, 7]))
        // 牛顿迭代：_Point<Double>(x: 4.774667829405002, y: 3.8614805729914004)
        // 模拟退火：_Point<Double>(x: 4.774664180916042, y: 3.8614777998604257)
        // (4.77466423312823, 3.861477846900622)
        XCTAssertTrue(fabs(fermet.x - 4.774664) < 1e-6)
        XCTAssertTrue(fabs(fermet.y - 3.861478) < 1e-6)
    }
}
