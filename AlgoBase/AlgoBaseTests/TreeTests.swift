//
//  TreeTests.swift
//  AlgoBaseTests
//
//  Created by ryfang on 2022/12/3.
//

import XCTest
@testable import AlgoBase

final class TreeTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testConstruct() {
        let arr = [3,9,20,nil,nil,15,7]
        let root = TreeNode.arrayToTree(arr)
        XCTAssertNotNil(root)
        XCTAssertEqual(root?.array() ?? [], arr)
    }

    func testInorder() {
        let root = TreeNode.arrayToTree([3,9,20,nil,nil,15,7])
        XCTAssertEqual(TreeNode.inOrder(root), [9,3,15,20,7])
        XCTAssertEqual(TreeNode.inOrderIterative(root), [9,3,15,20,7])
    }

    func testPreOrder() {
        let root = TreeNode.arrayToTree([3,9,20,nil,nil,15,7])
        XCTAssertEqual(TreeNode.preOrder(root), [3,9,20,15,7])
        XCTAssertEqual(TreeNode.preOrderIterative(root), [3,9,20,15,7])
    }

    func testPostOrder() {
        let root = TreeNode.arrayToTree([3,9,20,nil,nil,15,7])
        XCTAssertEqual(TreeNode.postOrder(root), [9,15,7,20,3])
        XCTAssertEqual(TreeNode.postOrderIterative(root), [9,15,7,20,3])
    }
}
