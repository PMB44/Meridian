import Foundation

/// The parts of Setup.
enum SetupArea: String, CaseIterable, Identifiable, Sendable {
    case onboarding
    case styleBlend
    case privacyAndData

    var id: String { rawValue }

    var title: String {
        switch self {
        case .onboarding: return "Onboarding"
        case .styleBlend: return "Style blend"
        case .privacyAndData: return "Privacy and data"
        }
    }
}
