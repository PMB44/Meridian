import SwiftUI

/// Renders the loading, empty, error or loaded state of a screen.
struct ScreenStateView<Value, Content: View>: View {
    let state: LoadState<Value>
    let emptyTitle: String
    let emptyDetail: String
    let retry: () -> Void
    @ViewBuilder let content: (Value) -> Content

    var body: some View {
        Group {
            switch state {
            case .loading:
                Text("Loading")
                    .meridianLabel(color: Palette.taupe)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            case .empty:
                message(title: emptyTitle, detail: emptyDetail)
            case .failed(let text):
                failure(text)
            case .loaded(let value):
                content(value)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }

    private func message(title: String, detail: String) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(Typography.title)
                .foregroundStyle(Palette.charcoal)
            Text(detail)
                .meridianCaption()
        }
        .padding(.horizontal, Layout.margin)
        .padding(.top, 28)
    }

    private func failure(_ text: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Error")
                .meridianLabel(color: Palette.deepRed)
            Text(text)
                .font(Typography.body)
                .foregroundStyle(Palette.deepRed)
            Button("Try again", action: retry)
                .buttonStyle(PrimaryButtonStyle())
        }
        .padding(.horizontal, Layout.margin)
        .padding(.top, 28)
    }
}

extension ScreenStateView where Value == Never, Content == EmptyView {
    /// For screens that have no content type yet.
    init(
        state: LoadState<Never>,
        emptyTitle: String,
        emptyDetail: String,
        retry: @escaping () -> Void
    ) {
        self.init(
            state: state,
            emptyTitle: emptyTitle,
            emptyDetail: emptyDetail,
            retry: retry,
            content: { _ in EmptyView() }
        )
    }
}
