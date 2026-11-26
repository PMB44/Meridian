import SwiftUI

/// Meridian colours. Use these names only. Do not introduce new colours.
enum Palette {
    /// Ground.
    static let bone = Color(hex: 0xF2EEE7)
    /// Page.
    static let page = Color(hex: 0xEDE8E0)
    /// Type and 2px rules.
    static let charcoal = Color(hex: 0x22201E)
    /// Small-caps labels.
    static let camel = Color(hex: 0xB08A56)
    /// Captions.
    static let taupe = Color(hex: 0x8A8378)
    /// 1px dividers.
    static let rule = Color(hex: 0xD8D0C2)
    /// Alerts and errors only. Always pair with text.
    static let deepRed = Color(hex: 0x7A1F1B)
}

/// Red, green and blue components of a 24-bit hex colour, each 0 to 1.
struct RGB: Equatable {
    let red: Double
    let green: Double
    let blue: Double

    init(hex: UInt32) {
        red = Double((hex >> 16) & 0xFF) / 255
        green = Double((hex >> 8) & 0xFF) / 255
        blue = Double(hex & 0xFF) / 255
    }
}

extension Color {
    init(hex: UInt32) {
        let rgb = RGB(hex: hex)
        self.init(.sRGB, red: rgb.red, green: rgb.green, blue: rgb.blue, opacity: 1)
    }
}
