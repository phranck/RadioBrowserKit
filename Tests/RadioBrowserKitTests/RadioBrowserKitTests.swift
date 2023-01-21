import XCTest
@testable import RadioBrowserKit

final class RadioBrowserKitTests: XCTestCase {
    func testVersion() throws {
        XCTAssertEqual(RadioBrowserAPI.version, "0.1.4")
    }
}
