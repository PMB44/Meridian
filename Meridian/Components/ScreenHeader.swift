import SwiftUI

/// Label, headline, then a 2px rule.
struct ScreenHeader: View {
    let label: String
    let title: String

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text(label)
                    .meridianLabel()
                Text(title)
                    .font(Typography.headline)
                    .foregroundStyle(Palette.charcoal)
                    .accessibilityAddTraits(.isHeader)
            }
            .padding(.horizontal, Layout.margin)
            .padding(.top, 20)
            .padding(.bottom, 16)

            SectionRule()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
