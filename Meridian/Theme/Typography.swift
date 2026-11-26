import SwiftUI

/// Bundled font faces. Raw values are PostScript names and match the .ttf file names.
enum Typeface: String, CaseIterable {
    case bodoniRegular = "BodoniModa-Regular"
    case bodoniMedium = "BodoniModa-Medium"
    case bodoniItalic = "BodoniModa-Italic"
    case archivoRegular = "Archivo-Regular"
    case archivoMedium = "Archivo-Medium"
    case archivoSemiBold = "Archivo-SemiBold"

    func font(size: CGFloat, relativeTo style: Font.TextStyle) -> Font {
        .custom(rawValue, size: size, relativeTo: style)
    }
}

/// Type scale. Bodoni Moda for headlines and figures. Archivo for everything else.
enum Typography {
    static let display = Typeface.bodoniRegular.font(size: 40, relativeTo: .largeTitle)
    static let headline = Typeface.bodoniRegular.font(size: 30, relativeTo: .title)
    static let title = Typeface.bodoniMedium.font(size: 20, relativeTo: .title3)
    static let figure = Typeface.bodoniRegular.font(size: 34, relativeTo: .title)

    static let body = Typeface.archivoRegular.font(size: 16, relativeTo: .body)
    static let bodyStrong = Typeface.archivoMedium.font(size: 16, relativeTo: .body)
    static let caption = Typeface.archivoRegular.font(size: 13, relativeTo: .footnote)
    static let label = Typeface.archivoSemiBold.font(size: 11, relativeTo: .caption)

    /// Letter spacing for labels.
    static let labelTracking: CGFloat = 1.6
}

extension View {
    /// Camel label. Archivo has no small-caps glyphs, so labels are set in tracked capitals.
    func meridianLabel(color: Color = Palette.camel) -> some View {
        self
            .font(Typography.label)
            .textCase(.uppercase)
            .tracking(Typography.labelTracking)
            .foregroundStyle(color)
    }

    /// Taupe caption.
    func meridianCaption() -> some View {
        self
            .font(Typography.caption)
            .foregroundStyle(Palette.taupe)
    }
}
