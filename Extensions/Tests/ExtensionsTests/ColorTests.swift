import XCTest
import SwiftUI
import Codextended
@testable import Extensions

final class ColorComponents: XCTestCase {
    func testBlackIsZero() throws {
        let (r, g, b, o) = Color.black.components
        XCTAssert([r, g, b].allSatisfy { $0.isApprox(0) })
        XCTAssert(o.isApprox(1))
    }
    func testWhiteIsOne() throws {
        let (r, g, b, o) = Color.white.components
        XCTAssert([r, g, b, o].allSatisfy { $0.isApprox(1) })
    }
    func testRed() throws {
        let (r, g, b, o) = Color(red: 1, green: 0, blue: 0).components
        XCTAssert([r, o].allSatisfy { $0.isApprox(1) })
        XCTAssert([g, b].allSatisfy { $0.isApprox(0) })
        
        let red = Color(red: 1, green: 0, blue: 0).red
        XCTAssert(CGFloat(red).isApprox(1))
    }
    func testGreen() throws {
        let green = Color(red: 0, green: 0.5, blue: 0).green
        XCTAssert(CGFloat(green).isApprox(0.5))
    }
    func testBlue() throws {
        let blue = Color(red: 0, green: 0.25, blue: 0.25).blue
        XCTAssert(CGFloat(blue).isApprox(0.25))
    }
    func testOpacity() throws {
        let opacity = Color(red: 0, green: 0.25, blue: 0.25, opacity: 0.5).opacity
        XCTAssert(CGFloat(opacity).isApprox(0.5))
    }
}

final class ColorHex: XCTestCase {
    func testToHex() throws {
        XCTAssert(["#000000", "#000000ff"].contains(Color.black.hex.lowercased()))
    }
}

final class ColorLuminance: XCTestCase {
    func testLuminance() throws {
        XCTAssert(Color.white.luminance > 0.5)
        XCTAssert(Color.black.luminance < 0.5)
        XCTAssert(Color(white: 0.6).luminance > 0.5)
        XCTAssert(Color(white: 0.4).luminance < 0.5)
    }
}

final class ColorContrast: XCTestCase {
    func testContasting() throws {
        XCTAssert(Color.white.contrasting.isDark)
        XCTAssert(Color.black.contrasting.isLight)
        XCTAssert(Color(red: 0.0, green: 0.0, blue: 0.5).contrasting.isLight)
    }
    func testContrast() throws {
        XCTAssert(Color.white.contrast(with: Color.white).isApprox(0))
        print(Color.white.contrast(with: Color.black))
        XCTAssert(Color.white.contrast(with: Color.black).isApprox(1))
    }
}

final class ColorLerp: XCTestCase {
    func testLerp() throws {
        let colorA = Color.black, colorB = Color.white
        let lerped = colorA.lerp(colorB, by: 0.25)
        XCTAssert(lerped.isApprox(
            Color(red: 0.25, green: 0.25, blue: 0.25, opacity: 1),
            epsilon: Color(white: 0.01, opacity: 0.01)
        ))
    }
    func testLerpAbove() throws {
        let colorA = Color.black, colorB = Color.white
        let lerped = colorA.lerp(colorB, by: 1.5)
        XCTAssert(lerped.isApprox(Color.white))
    }
    func testLerpBelow() throws {
        let colorA = Color.black, colorB = Color.white
        let lerped = colorA.lerp(colorB, by: -1.0)
        XCTAssert(lerped.isApprox(Color.black))
    }
}

private let blackJson = "{\"opacity\":1,\"red\":0,\"blue\":0,\"green\":0}"

final class ColorEncode: XCTestCase {
    func testEncodeDecode() throws {
        let color = Color.white
        let data = try color.encoded()
        let decodedColor = try data.decoded() as Color
        XCTAssert(color.isApprox(decodedColor))
    }
    func testJsonSerialization() throws {
        let color = Color.black
        XCTAssertEqual(Optional.some(blackJson), color.json())
    }
    func testJsonDeserialization() throws {
        XCTAssert(Color.black.isApprox(Color(json: blackJson) ?? Color.white))
    }
}
