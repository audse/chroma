//
//  ChromaTests.swift
//  ChromaTests
//
//  Created by Audrey Serene on 9/11/23.
//

import XCTest
import Chroma
import SwiftUI

final class ChromaTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class ColorExtensionTest: XCTestCase {
    func testComponents() throws {
        XCTAssert(Color.black.components == (0, 0, 0, 1))
        let (r, g, b, o) = Color.white.components
        XCTAssert(r.isApprox(1))
        XCTAssert(g.isApprox(1))
        XCTAssert(b.isApprox(1))
        XCTAssert(o.isApprox(1))
    }
    
    func testHex() throws {
        XCTAssert(["#000000", "#000000ff"].contains(Color.black.hex.lowercased()))
    }
    
    func testLuminance() throws {
        XCTAssert(Color.white.luminance > 0.5)
        XCTAssert(Color.black.luminance < 0.5)
        XCTAssert(Color(white: 0.6).luminance > 0.5)
        XCTAssert(Color(white: 0.4).luminance < 0.5)
    }
    
    func testContasting() throws {
        XCTAssert(Color.white.contrasting.isDark)
        XCTAssert(Color.black.contrasting.isLight)
        XCTAssert(Color(red: 0.0, green: 0.0, blue: 0.5).contrasting.isLight)
    }
}

final class SequenceExtensionTest: XCTestCase {
    func testFilterOut() throws {
        let a: [Int] = [1, 2, 3, 4]
        let b: [Int] = [2, 4, 6, 8]
        XCTAssert(a.filterOut({ element in element == 1 }).count == 3)
        XCTAssert(a.filterOut(b.contains).elementsEqual([1, 3]))
    }
    
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
    
    func testGet() throws {
        let items: [Int] = [1, 2, 3, 4]
        XCTAssert(items.get(at: 0) == .some(1))
        XCTAssert(items.get(at: -1) == nil)
        XCTAssert(items.get(at: 4) == nil)
    }
    
    func testGrouped() throws {
        let items: [Int] = [1, 2, 3, 4]
        let groups = items.grouped(by: 2)
        XCTAssert(groups.count == 2)
        XCTAssert(groups[0].elementsEqual([1, 2]))
        XCTAssert(groups[1].elementsEqual([3, 4]))
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
