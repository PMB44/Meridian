import XCTest
@testable import Meridian

final class UserMessageTests: XCTestCase {
    private struct SampleError: Error {}

    func testTimeoutMessage() {
        XCTAssertEqual(UserMessage.text(for: TimeoutError()), UserMessage.timedOut)
        XCTAssertEqual(UserMessage.text(for: URLError(.timedOut)), UserMessage.timedOut)
    }

    func testOfflineMessage() {
        XCTAssertEqual(UserMessage.text(for: URLError(.notConnectedToInternet)), UserMessage.offline)
        XCTAssertEqual(UserMessage.text(for: URLError(.networkConnectionLost)), UserMessage.offline)
    }

    func testUnknownErrorsGetGenericMessage() {
        XCTAssertEqual(UserMessage.text(for: SampleError()), UserMessage.generic)
        XCTAssertEqual(UserMessage.text(for: URLError(.badServerResponse)), UserMessage.generic)
    }

    func testVoiceRules() {
        for message in [UserMessage.timedOut, UserMessage.offline, UserMessage.generic] {
            XCTAssertFalse(message.contains("!"))
            XCTAssertFalse(message.contains("\u{2014}"))
        }
    }
}
