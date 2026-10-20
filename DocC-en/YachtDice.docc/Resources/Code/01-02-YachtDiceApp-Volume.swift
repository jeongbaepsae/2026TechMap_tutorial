import SwiftUI

@main
struct YachtDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
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
