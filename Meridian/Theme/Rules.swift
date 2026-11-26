import SwiftUI

/// 2px charcoal rule. Separates sections.
struct SectionRule: View {
    var body: some View {
        Rectangle()
            .fill(Palette.charcoal)
            .frame(height: Layout.sectionRuleHeight)
            .accessibilityHidden(true)
    }
}

/// 1px rule. Separates rows.
struct RowRule: View {
    var body: some View {
        Rectangle()
            .fill(Palette.rule)
            .frame(height: Layout.rowRuleHeight)
            .accessibilityHidden(true)
    }
}
