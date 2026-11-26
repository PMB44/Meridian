import SwiftUI

struct SetupView: View {
    @State private var model = ScreenViewModel<[SetupArea]>(loader: { SetupArea.allCases })

    var body: some View {
        VStack(spacing: 0) {
            ScreenHeader(label: "Setup", title: "Your settings.")
            ScreenStateView(
                state: model.state,
                emptyTitle: "Nothing to set up.",
                emptyDetail: "Settings will appear here.",
                retry: { Task { await model.load() } }
            ) { areas in
                VStack(spacing: 0) {
                    ForEach(areas) { area in
                        HStack(alignment: .firstTextBaseline) {
                            Text(area.title)
                                .font(Typography.body)
                                .foregroundStyle(Palette.charcoal)
                            Spacer()
                            Text("Not available yet")
                                .meridianCaption()
                        }
                        .padding(.horizontal, Layout.margin)
                        .frame(minHeight: 56)
                        .accessibilityElement(children: .combine)
                        RowRule()
                    }
                }
            }
        }
        .task { await model.load() }
    }
}

#Preview {
    SetupView()
        .background(Palette.bone)
}
