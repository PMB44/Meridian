import SwiftUI

struct WardrobeView: View {
    @State private var model = ScreenViewModel<Never>(loader: { nil })

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(label: "Wardrobe", title: "What you own.")
            ScreenStateView(
                state: model.state,
                emptyTitle: "Your wardrobe is empty.",
                emptyDetail: "Garments you add will appear here.",
                retry: { Task { await model.load() } }
            )
        }
        .task { await model.load() }
    }
}

#Preview {
    WardrobeView()
        .background(Palette.bone)
}
