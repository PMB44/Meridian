import Foundation

/// The four MVP tabs, in display order.
enum AppTab: String, CaseIterable, Identifiable {
    case today
    case wardrobe
    case shop
    case stylist

    var id: String { rawValue }

    var title: String {
        switch self {
        case .today: return "Today"
        case .wardrobe: return "Wardrobe"
        case .shop: return "Shop"
        case .stylist: return "Stylist"
        }
    }
}
