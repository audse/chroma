import XCTest
import SwiftUI
@testable import Extensions

final class SequenceFilter: XCTestCase {
    func testFilterOut() throws {
        let a: [Int] = [1, 2, 3, 4]
        let b: [Int] = [2, 4, 6, 8]
        XCTAssert(a.filterOut({ element in element == 1 }).count == 3)
        XCTAssert(a.filterOut(b.contains).elementsEqual([1, 3]))
    }
    func testFilterSome() throws {
        let items: [Int?] = [.some(1), .some(2), nil, nil]
        XCTAssert(items.filterSome().elementsEqual([1, 2]))
    }
    func testUnique() throws {
        let items: [Int] = [1, 1, 2, 2]
        XCTAssert(items.unique().elementsEqual([1, 2]))
    }
}

final class SequenceRemove: XCTestCase {
    func testRemove() throws {
        var items: [Int] = [1, 2, 3, 4]
        items.remove(1)
        XCTAssert(items.elementsEqual([2, 3, 4]))
        items.remove(5)
        XCTAssert(items.elementsEqual([2, 3, 4]))
    }
    func testRemoveEach() throws {
        var items: [Int] = [1, 2, 3, 4]
        items.removeEach([2, 4])
        XCTAssert(items.elementsEqual([1, 3]))
    }
}

final class SequenceBoolean: XCTestCase {
    func testIntersection() throws {
        let itemsA: [Int] = [1, 2, 3, 4]
        let itemsB: [Int] = [2, 4, 6, 8]
        XCTAssert(itemsA.intersection(itemsB).elementsEqual([2, 4]))
    }
    func testXor() throws {
        let itemsA: [Int] = [1, 2, 3, 4]
        let itemsB: [Int] = [2, 3, 4, 5]
        XCTAssert(itemsA.xor(itemsB).elementsEqual([1, 5]))
    }
}

final class SequenceGet: XCTestCase {
    func testGet() throws {
        let items: [Int] = [1, 2, 3, 4]
        XCTAssert(items.get(at: 0) == .some(1))
        XCTAssert(items.get(at: -1) == nil)
        XCTAssert(items.get(at: 4) == nil)
    }
}

final class SequenceMap: XCTestCase {
    func testGrouped() throws {
        let items: [Int] = [1, 2, 3, 4]
        let groups = items.grouped(by: 2)
        XCTAssert(groups.count == 2)
        XCTAssert(groups[0].elementsEqual([1, 2]))
        XCTAssert(groups[1].elementsEqual([3, 4]))
    }
}
