import SwiftUI

/// App shell: masthead, the selected tab, and the tab bar. Setup opens over the tabs.
struct RootView: View {
    @State private var selection: AppTab = .today
    @State private var showingSetup = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion

    var body: some View {
        VStack(spacing: 0) {
            Masthead(showingSetup: $showingSetup)

            ZStack {
                if showingSetup {
                    SetupView()
                        .transition(screenTransition)
                } else {
                    tabScreen
                        .id(selection)
                        .transition(screenTransition)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .animation(Motion.screen, value: selection)
            .animation(Motion.screen, value: showingSetup)

            if !showingSetup {
                TabBar(selection: $selection)
            }
        }
        .background(Palette.bone.ignoresSafeArea())
        .preferredColorScheme(.light)
    }

    @ViewBuilder
    private var tabScreen: some View {
        switch selection {
        case .today: TodayView()
        case .wardrobe: WardrobeView()
        case .shop: ShopView()
        case .stylist: StylistView()
        }
    }

    private var screenTransition: AnyTransition {
        reduceMotion ? .opacity : .fadeRise
    }
}

private struct Masthead: View {
    @Binding var showingSetup: Bool

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text("Meridian")
                .font(Typography.title)
                .foregroundStyle(Palette.charcoal)
            Spacer()
            Button(showingSetup ? "Close" : "Setup") {
                showingSetup.toggle()
            }
            .buttonStyle(TextButtonStyle())
        }
        .padding(.horizontal, Layout.margin)
        .frame(minHeight: Layout.minTapTarget)
    }
}

#Preview {
    RootView()
}
