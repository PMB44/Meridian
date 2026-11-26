import XCTest
@testable import Meridian

@MainActor
final class ScreenViewModelTests: XCTestCase {
    private struct SampleError: Error {}

    func testStartsLoading() {
        let model = ScreenViewModel<Int>(loader: { 1 })
        XCTAssertEqual(model.state, .loading)
    }

    func testNilContentBecomesEmpty() async {
        let model = ScreenViewModel<Int>(loader: { nil })
        await model.load()
        XCTAssertEqual(model.state, .empty)
    }

    func testContentBecomesLoaded() async {
        let model = ScreenViewModel<Int>(loader: { 7 })
        await model.load()
        XCTAssertEqual(model.state, .loaded(7))
    }

    func testErrorBecomesFailedWithUserMessage() async {
        let model = ScreenViewModel<Int>(loader: { throw SampleError() })
        await model.load()
        XCTAssertEqual(model.state, .failed(UserMessage.generic))
    }

    func testSlowLoaderTimesOut() async {
        let model = ScreenViewModel<Int>(timeout: .milliseconds(50)) {
            try await Task.sleep(for: .seconds(5))
            return 1
        }
        await model.load()
        XCTAssertEqual(model.state, .failed(UserMessage.timedOut))
    }

    func testRetryRecoversAfterFailure() async {
        let attempts = Counter()
        let model = ScreenViewModel<Int> {
            if await attempts.next() == 1 { throw SampleError() }
            return 3
        }
        await model.load()
        XCTAssertEqual(model.state, .failed(UserMessage.generic))
        await model.load()
        XCTAssertEqual(model.state, .loaded(3))
    }
}

private actor Counter {
    private var value = 0

    func next() -> Int {
        value += 1
        return value
    }
}
