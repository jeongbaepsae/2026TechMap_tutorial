import SwiftUI

@MainActor
@main
struct YachtDiceApp: App {
    @State private var game = YachtGame()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(game)
        }
        .windowStyle(.volumetric)
        .defaultSize(
            width: 1,
            height: 1,
            depth: 1,
            in: .meters
        )
    }
}
