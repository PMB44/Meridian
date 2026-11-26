import SwiftUI

/// Motion: 350 to 500ms, ease-out. Nothing bounces.
enum Motion {
    static let screenDuration: Double = 0.42
    static let quickDuration: Double = 0.35
    static let riseDistance: CGFloat = 14

    static let screen = Animation.easeOut(duration: screenDuration)
    static let quick = Animation.easeOut(duration: quickDuration)
}

extension AnyTransition {
    /// Screens fade in and rise 14pt. They fade out in place.
    static var fadeRise: AnyTransition {
        .asymmetric(
            insertion: .opacity.combined(with: .offset(y: Motion.riseDistance)),
            removal: .opacity
        )
    }
}
