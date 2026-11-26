import Foundation

/// The four states every screen ships with.
enum LoadState<Value> {
    case loading
    case empty
    case loaded(Value)
    /// Carries a message that is safe to show the user.
    case failed(String)
}

extension LoadState: Equatable where Value: Equatable {}
