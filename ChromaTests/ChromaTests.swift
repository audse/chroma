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

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}

final class SequenceExtensionTest: XCTestCase {
    func testContains() throws {
        let a = PixelModel()
        let items: [PixelModel] = [a, PixelModel(), PixelModel()]
        XCTAssert(items.contains(a))
        XCTAssert(!items.contains(PixelModel()))
    }
    
    func testFilterOut() throws {
        let a: [Int] = [1, 2, 3, 4]
        let b: [Int] = [2, 4, 6, 8]
        XCTAssert(a.filterOut({ el in el == 1 }).count == 3)
        XCTAssert(a.filterOut(b.contains).elementsEqual([1, 3]))
    }
}
