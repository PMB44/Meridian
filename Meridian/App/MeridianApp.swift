import SwiftUI

@main
struct MeridianApp: App {
    init() {
        FontRegistrar.registerAll()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
