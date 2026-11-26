import UIKit
import XCTest
@testable import Meridian

final class ShellTests: XCTestCase {
    func testTabsAreTheFourMVPTabsInOrder() {
        XCTAssertEqual(AppTab.allCases.map(\.title), ["Today", "Wardrobe", "Shop", "Stylist"])
    }

    func testSetupAreas() {
        XCTAssertEqual(SetupArea.allCases.map(\.title), ["Onboarding", "Style blend", "Privacy and data"])
    }

    func testHexComponents() {
        let bone = RGB(hex: 0xF2EEE7)
        XCTAssertEqual(bone.red, 242.0 / 255, accuracy: 0.0001)
        XCTAssertEqual(bone.green, 238.0 / 255, accuracy: 0.0001)
        XCTAssertEqual(bone.blue, 231.0 / 255, accuracy: 0.0001)
    }

    func testEveryBundledFontLoads() {
        let failed = FontRegistrar.registerAll(in: .main)
        XCTAssertEqual(failed, [])
        for face in Typeface.allCases {
            XCTAssertNotNil(UIFont(name: face.rawValue, size: 12), "\(face.rawValue) did not load")
        }
    }

    func testMotionStaysWithinBrief() {
        for duration in [Motion.screenDuration, Motion.quickDuration] {
            XCTAssertTrue((0.35...0.5).contains(duration))
        }
        XCTAssertEqual(Motion.riseDistance, 14)
    }
}
