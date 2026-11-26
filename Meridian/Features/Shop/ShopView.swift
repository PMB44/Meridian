import SwiftUI

struct ShopView: View {
    @State private var model = ScreenViewModel<Never>(loader: { nil })

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(label: "Shop", title: "What is missing.")
            ScreenStateView(
                state: model.state,
                emptyTitle: "Nothing missing yet.",
                emptyDetail: "Gaps in your wardrobe will appear here.",
                retry: { Task { await model.load() } }
            )
        }
        .task { await model.load() }
    }
}

#Preview {
    ShopView()
        .background(Palette.bone)
}
