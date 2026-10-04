//
//  TestCaseLoader.swift
//  Tangram
//

import Foundation

// MARK: - Data Model

struct TestCase {
    let inputs: [String]
    let expected: String
}

// MARK: - Input Parsers

extension TestCase {
    func int(_ i: Int) -> Int {
        Int(inputs[i].trimmingCharacters(in: .whitespaces))!
    }

    func double(_ i: Int) -> Double {
        Double(inputs[i].trimmingCharacters(in: .whitespaces))!
    }

    func bool(_ i: Int) -> Bool {
        inputs[i].trimmingCharacters(in: .whitespaces).lowercased() == "true"
    }

    func string(_ i: Int) -> String {
        var s = inputs[i].trimmingCharacters(in: .whitespaces)
        if s.hasPrefix("\"") && s.hasSuffix("\"") {
            s = String(s.dropFirst().dropLast())
        }
        return s
    }

    func char(_ i: Int) -> Character {
        Character(string(i))
    }

    func intArray(_ i: Int) -> [Int] {
        JSONParse.array(inputs[i])
    }

    func intArray2D(_ i: Int) -> [[Int]] {
        JSONParse.array2D(inputs[i])
    }

    func doubleArray(_ i: Int) -> [Double] {
        JSONParse.array(inputs[i])
    }

    func stringArray(_ i: Int) -> [String] {
        JSONParse.array(inputs[i])
    }

    func stringArray2D(_ i: Int) -> [[String]] {
        JSONParse.array2D(inputs[i])
    }

    func boolArray(_ i: Int) -> [Bool] {
        JSONParse.array(inputs[i])
    }

    func charArray(_ i: Int) -> [Character] {
        let strings: [String] = JSONParse.array(inputs[i])
        return strings.map { Character($0) }
    }

    func charArray2D(_ i: Int) -> [[Character]] {
        let strings: [[String]] = JSONParse.array2D(inputs[i])
        return strings.map { $0.map { Character($0) } }
    }

    func treeNode(_ i: Int) -> TreeNode? {
        TreeNode.arrayToTree(JSONParse.optionalIntArray(inputs[i]))
    }

    func listNode(_ i: Int) -> ListNode? {
        ListNode.arrayToList(JSONParse.array(inputs[i]) as [Int])
    }
}

// MARK: - Expected Value Parsers

extension TestCase {
    var expectedInt: Int { Int(expected.trimmingCharacters(in: .whitespaces))! }
    var expectedDouble: Double { Double(expected.trimmingCharacters(in: .whitespaces))! }
    var expectedBool: Bool { expected.trimmingCharacters(in: .whitespaces).lowercased() == "true" }

    var expectedString: String {
        var s = expected.trimmingCharacters(in: .whitespaces)
        if s.hasPrefix("\"") && s.hasSuffix("\"") {
            s = String(s.dropFirst().dropLast())
        }
        return s
    }

    var expectedChar: Character { Character(expectedString) }
    var expectedIntArray: [Int] { JSONParse.array(expected) }
    var expectedIntArray2D: [[Int]] { JSONParse.array2D(expected) }
    var expectedDoubleArray: [Double] { JSONParse.array(expected) }
    var expectedStringArray: [String] { JSONParse.array(expected) }
    var expectedStringArray2D: [[String]] { JSONParse.array2D(expected) }
    var expectedBoolArray: [Bool] { JSONParse.array(expected) }

    var expectedCharArray: [Character] {
        let strings: [String] = JSONParse.array(expected)
        return strings.map { Character($0) }
    }

    var expectedOptionalIntArray: [Int?] {
        JSONParse.optionalIntArray(expected)
    }
}

// MARK: - JSON Parsing Helpers

private enum JSONParse {
    static func array<T: Decodable>(_ raw: String) -> [T] {
        let s = raw.trimmingCharacters(in: .whitespaces)
        guard let data = s.data(using: .utf8),
              let result = try? JSONDecoder().decode([T].self, from: data) else {
            return []
        }
        return result
    }

    static func array2D<T: Decodable>(_ raw: String) -> [[T]] {
        let s = raw.trimmingCharacters(in: .whitespaces)
        guard let data = s.data(using: .utf8),
              let result = try? JSONDecoder().decode([[T]].self, from: data) else {
            return []
        }
        return result
    }

    static func optionalIntArray(_ raw: String) -> [Int?] {
        let s = raw.trimmingCharacters(in: .whitespaces)
        guard s.hasPrefix("[") && s.hasSuffix("]") else { return [] }
        let inner = String(s.dropFirst().dropLast())
            .trimmingCharacters(in: .whitespaces)
        if inner.isEmpty { return [] }
        return inner.split(separator: ",", omittingEmptySubsequences: false).map {
            let token = $0.trimmingCharacters(in: .whitespaces)
            return token == "null" ? nil : Int(token)
        }
    }
}

// MARK: - Loader

func loadTestCases(_ id: Int) -> [TestCase] {
    let dir = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent() // Runner/
        .deletingLastPathComponent() // Tangram/
        .appendingPathComponent("TestCases")
    let url = dir.appendingPathComponent("\(id).json")

    guard let data = try? Data(contentsOf: url),
          let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
          let casesArray = json["cases"] as? [[String: Any]] else {
        return []
    }

    return casesArray.compactMap { c in
        guard let inputs = c["inputs"] as? [String],
              let expected = c["expected"] as? String else { return nil }
        return TestCase(inputs: inputs, expected: expected)
    }
}
