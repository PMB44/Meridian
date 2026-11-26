import SwiftUI

struct StylistView: View {
    @State private var model = ScreenViewModel<Never>(loader: { nil })

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(label: "Stylist", title: "Ask your stylist.")
            ScreenStateView(
                state: model.state,
                emptyTitle: "No conversation yet.",
                emptyDetail: "Your questions and answers will appear here.",
                retry: { Task { await model.load() } }
            )
        }
        .task { await model.load() }
    }
}

#Preview {
    StylistView()
        .background(Palette.bone)
}
