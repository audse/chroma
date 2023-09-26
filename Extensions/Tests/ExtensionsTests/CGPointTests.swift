import XCTest
import SwiftUI
@testable import Extensions

final class CGPointInit: XCTestCase {
    func testInit() throws {
        let pointA = CGPoint(0)
        XCTAssert(pointA.isApprox(CGPoint(0)))
        
        let pointB = CGPoint(1, 1)
        XCTAssert(pointB.isApprox(CGPoint(1)))
        
        let size = CGSize(width: 2, height: 1)
        let pointC = CGPoint(size)
        XCTAssert(pointC.isApprox(CGPoint(2, 1)))
    }
}

final class CGPointApprox: XCTestCase {
    func testIsApprox() throws {
        XCTAssert(CGPoint(0).isApprox(CGPoint(0)) == true)
        XCTAssert(CGPoint(0).isApprox(CGPoint(1)) == false)
    }
}

final class CGPointDistance: XCTestCase {
    func testDistance() throws {
        let distA = CGPoint(x: 1, y: 1).distance(to: CGPoint(x: 1, y: 2))
        XCTAssert(distA.isApprox(1))
    }
    func testDistanceNotMoved() throws {
        let distA = CGPoint(x: 1, y: 1).distance(to: CGPoint(x: 1, y: 1))
        XCTAssert(distA.isApprox(0))
    }
    func testMoveToward() throws {
        let point = CGPoint(x: 1, y: 1).moveToward(CGPoint(x: 1, y: 2), by: 0.5)
        XCTAssert(point.isApprox(CGPoint(x: 1, y: 1.5)))
    }
    func testMovePast() throws {
        let point = CGPoint(x: 1, y: 1).moveToward(CGPoint(x: 1, y: 1), by: 0.5)
        XCTAssert(point.isApprox(CGPoint(x: 1, y: 1)))
    }
    func testMoveBehind() throws {
        let point = CGPoint(x: 1, y: 1).moveToward(CGPoint(x: -1, y: 1), by: 0.5)
        XCTAssert(point.isApprox(CGPoint(x: 0.5, y: 1)))
    }
    func testLength() throws {
        let length = CGPoint(x: 1, y: 1).length
        XCTAssert(length.isApprox(sqrt(2)))
    }
}

final class CGPointOperators: XCTestCase {
    func testAdd() throws {
        XCTAssert((CGPoint(1) + CGPoint(1)).isApprox(CGPoint(2)))
    }
    func testSubtract() throws {
        XCTAssert((CGPoint(1) - CGPoint(1)).isApprox(CGPoint(0)))
    }
    func testMultiply() throws {
        XCTAssert((CGPoint(1) * CGPoint(1)).isApprox(CGPoint(1)))
        XCTAssert((CGPoint(2) * 0.5).isApprox(CGPoint(1)))
    }
    func testDivide() throws {
        XCTAssert((CGPoint(1) / CGPoint(2)).isApprox(CGPoint(0.5)))
        XCTAssert((CGPoint(1) / 2).isApprox(CGPoint(0.5)))
    }
}

final class CGPointRotated: XCTestCase {
    func test45() throws {
        XCTAssert(CGPoint(x: sqrt(2), y: 0).rotated(Angle(degrees: 45)).isApprox(CGPoint(x: 1, y: 1)))
    }
    func test90() throws {
        XCTAssert(CGPoint(x: 1, y: 0).rotated(Angle(degrees: 90)).isApprox(CGPoint(x: 0, y: 1)))
    }
    func test180() throws {
        XCTAssert(CGPoint(1).rotated(Angle(degrees: 180)).isApprox(CGPoint(-1)))
    }
}

final class CGPointConversion: XCTestCase {
    func testCGSize() throws {
        XCTAssert(CGPoint(1).size.isApprox(CGSize(1)))
    }
}

final class CGPointLerp: XCTestCase {
    func testLerp() throws {
        let pointA = CGPoint(0), pointB = CGPoint(x: 1, y: 0)
        let lerped = pointA.lerp(pointB, by: 0.25)
        XCTAssert(lerped.isApprox(CGPoint(x: 0.25, y: 0)))
    }
    func testLerpAbove() throws {
        let pointA = CGPoint(0), pointB = CGPoint(x: 1, y: 0)
        let lerped = pointA.lerp(pointB, by: 2.0)
        XCTAssert(lerped.isApprox(CGPoint(x: 2, y: 0)))
    }
    func testLerpBelow() throws {
        let pointA = CGPoint(0), pointB = CGPoint(x: 1, y: 0)
        let lerped = pointA.lerp(pointB, by: -2.0)
        XCTAssert(lerped.isApprox(CGPoint(x: -2, y: 0)))
    }
}
