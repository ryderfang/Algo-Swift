//
//  GeometryTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2023/12/20.
//

import XCTest
@testable import AlgoBase

final class GeometryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPoints() {
        let (p1, p2, p3) = ([0, 0], [1, 2], [2, 4])
        XCTAssertTrue(Geometry.checkStraightLine(p1, p2, p3))
        XCTAssertEqual(Geometry.distance(Double(p1[0]), Double(p1[1]), Double(p2[0]), Double(p2[1])), sqrt(5.0))
    }

    func testLine() {
        let (p1, p2) = ([0.0, 0.0], [2.0, 4.0])
        let p = [1.0, 2.0]
        XCTAssertTrue(Geometry.dotOnLine(p[0], p[1], p1[0], p1[1], p2[0], p2[1]))
        XCTAssertTrue(Geometry.dotOnLine(p1[0], p1[1], p1[0], p1[1], p2[0], p2[1]))
        XCTAssertFalse(Geometry.dotOnLine_Ex(p1[0], p1[1], p1[0], p1[1], p2[0], p2[1]))

        let line = Geometry.lineOfDots(0, 1, 1, 3)
        XCTAssertEqual(line.0, 2.0)
        XCTAssertEqual(line.1, 1.0)
    }

    func testTriangle() {
        let (p0, p1, p2) = ([0.0, 0.0], [0.0, 4.0], [3.0, 0.0])
        XCTAssertEqual(Geometry.triArea(p0[0], p0[1], p1[0], p1[1], p2[0], p2[1]), 6.0)
        XCTAssertEqual(Geometry.triArea(3.0, 4.0, 5.0), 6.0)
    }
}
