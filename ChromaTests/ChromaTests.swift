//
//  ChromaTests.swift
//  ChromaTests
//
//  Created by Audrey Serene on 9/11/23.
//

import XCTest
import Chroma

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
}
