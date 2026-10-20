import SwiftUI
import RealityKit

struct ContentView: View {
    @Environment(YachtGame.self) private var game

    var body: some View {
        RealityView { content in
            content.add(game.root)
        }
    }
}
