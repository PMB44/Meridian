import XCTest
@testable import Meridian

final class TimeoutTests: XCTestCase {
    private struct SampleError: Error, Equatable {}

    func testReturnsValueWhenFastEnough() async throws {
        let value = try await withTimeout(.seconds(5)) { 42 }
        XCTAssertEqual(value, 42)
    }

    func testThrowsTimeoutWhenTooSlow() async {
        do {
            _ = try await withTimeout(.milliseconds(50)) {
                try await Task.sleep(for: .seconds(5))
                return 1
            }
            XCTFail("Expected a timeout")
        } catch {
            XCTAssertTrue(error is TimeoutError)
        }
    }

    func testPassesThroughOperationError() async {
        do {
            _ = try await withTimeout(.seconds(5)) { () async throws -> Int in
                throw SampleError()
            }
            XCTFail("Expected an error")
        } catch {
            XCTAssertTrue(error is SampleError)
        }
    }
}
