import SwiftUI

struct TodayView: View {
    @State private var model = ScreenViewModel<Never>(loader: { nil })

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(label: "Today", title: "What to wear.")
            ScreenStateView(
                state: model.state,
                emptyTitle: "Nothing to wear yet.",
                emptyDetail: "Add what you own to your wardrobe. Today starts there.",
                retry: { Task { await model.load() } }
            )
        }
        .task { await model.load() }
    }
}

#Preview {
    TodayView()
        .background(Palette.bone)
}
