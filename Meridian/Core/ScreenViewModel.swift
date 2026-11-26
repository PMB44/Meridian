import Foundation
import Observation

/// Drives one screen through loading, empty, loaded and failed.
/// The loader returns nil when there is nothing to show.
@MainActor
@Observable
final class ScreenViewModel<Content: Sendable> {
    private(set) var state: LoadState<Content> = .loading

    private let timeout: Duration
    private let loader: @Sendable () async throws -> Content?

    init(
        timeout: Duration = .seconds(15),
        loader: @escaping @Sendable () async throws -> Content?
    ) {
        self.timeout = timeout
        self.loader = loader
    }

    /// Loads or reloads the screen. Also used by the error state's retry.
    func load() async {
        state = .loading
        do {
            if let content = try await withTimeout(timeout, operation: loader) {
                state = .loaded(content)
            } else {
                state = .empty
            }
        } catch {
            state = .failed(UserMessage.text(for: error))
        }
    }
}
