import XCTest
import SwiftUI
import Codextended
@testable import Extensions

final class AngleDegreesWrapped: XCTestCase {
    func testDegreesWrappedAbove() throws {
        let angleA = Angle(degrees: 365)
        let degrees = angleA.degreesWrapped
        XCTAssert(degrees.isApprox(5))
    }
    func testDegreesWrappedBelow() throws {
        let angleA = Angle(degrees: -5)
        let degrees = angleA.degreesWrapped
        XCTAssert(degrees.isApprox(355))
    }
}

final class AngleIsApprox: XCTestCase {
    func testIsApprox() throws {
        let angleA = Angle(degrees: 45)
        let angleB = Angle(degrees: 45.000001)
        XCTAssert(angleA.isApprox(angleB) == true)
    }
    func testIsNotApprox() throws {
        let angleA = Angle(degrees: 45)
        let angleB = Angle(degrees: 46)
        XCTAssert(angleA.isApprox(angleB) == false)
    }
}

final class AngleCodable: XCTestCase {
    func testEncodeDecodeDegrees() throws {
        let angle = Angle(degrees: 45)
        let data = try angle.encoded()
        let decodedAngle = try data.decoded() as Angle
        XCTAssert(angle.isApprox(decodedAngle))
    }
    func testEncodeDecodeRadians() throws {
        let angle = Angle(radians: 1)
        let data = try angle.encoded()
        let decodedAngle = try data.decoded() as Angle
        XCTAssert(angle.isApprox(decodedAngle))
    }
}

final class AngleLerp: XCTestCase {
    func testLerp() throws {
        let angleA = Angle(degrees: 0)
        let angleB = Angle(degrees: 90)
        let lerped = angleA.lerp(angleB, by: 0.5)
        XCTAssert(lerped.isApprox(Angle(degrees: 45)))
    }
    func testLerpAbove() throws {
        let angleA = Angle(degrees: 0)
        let angleB = Angle(degrees: 90)
        let lerped = angleA.lerp(angleB, by: 2.0)
        XCTAssert(lerped.isApprox(Angle(degrees: 180)))
    }
    func testLerpBelow() throws {
        let angleA = Angle(degrees: 0)
        let angleB = Angle(degrees: 90)
        let lerped = angleA.lerp(angleB, by: -0.5)
        XCTAssert(lerped.isApprox(Angle(degrees: -45)))
    }
}
