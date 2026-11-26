import SwiftUI

/// Four text tabs under a 2px rule. No icons, no rounded corners.
struct TabBar: View {
    @Binding var selection: AppTab

    var body: some View {
        VStack(spacing: 0) {
            SectionRule()
            HStack(spacing: 0) {
                ForEach(AppTab.allCases) { tab in
                    Button {
                        selection = tab
                    } label: {
                        Text(tab.title)
                            .meridianLabel(color: tab == selection ? Palette.charcoal : Palette.taupe)
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)
                    .accessibilityAddTraits(tab == selection ? .isSelected : [])
                }
            }
        }
        .background(Palette.bone)
    }
}
