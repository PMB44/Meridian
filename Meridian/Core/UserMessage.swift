import Foundation

/// Turns errors into copy that is safe to show. Short, declarative, no hype.
enum UserMessage {
    static let timedOut = "This took too long. Try again."
    static let offline = "No connection. Check your network and try again."
    static let generic = "Something went wrong. Try again."

    static func text(for error: Error) -> String {
        if error is TimeoutError {
            return timedOut
        }
        if let urlError = error as? URLError {
            switch urlError.code {
            case .timedOut:
                return timedOut
            case .notConnectedToInternet, .networkConnectionLost, .dataNotAllowed:
                return offline
            default:
                return generic
            }
        }
        return generic
    }
}
