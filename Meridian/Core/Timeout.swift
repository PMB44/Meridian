import Foundation

struct TimeoutError: Error, Equatable {}

/// Runs `operation` and throws `TimeoutError` if it has not finished in time.
/// The operation is cancelled on timeout. It must respond to cancellation, as URLSession does.
func withTimeout<T: Sendable>(
    _ timeout: Duration,
    operation: @escaping @Sendable () async throws -> T
) async throws -> T {
    try await withThrowingTaskGroup(of: T.self) { group in
        group.addTask {
            try await operation()
        }
        group.addTask {
            try await Task.sleep(for: timeout)
            throw TimeoutError()
        }
        defer { group.cancelAll() }
        guard let first = try await group.next() else {
            throw TimeoutError()
        }
        return first
    }
}
