import SwiftUI

/// Solid charcoal button. Square corners.
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .meridianLabel(color: Palette.bone)
            .padding(.horizontal, 20)
            .frame(minHeight: Layout.minTapTarget)
            .background(Palette.charcoal)
            .opacity(configuration.isPressed ? 0.7 : 1)
            .animation(Motion.quick, value: configuration.isPressed)
    }
}

/// Text-only button set as a label.
struct TextButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .meridianLabel(color: Palette.charcoal)
            .frame(minWidth: Layout.minTapTarget, minHeight: Layout.minTapTarget)
            .contentShape(Rectangle())
            .opacity(configuration.isPressed ? 0.5 : 1)
            .animation(Motion.quick, value: configuration.isPressed)
    }
}
