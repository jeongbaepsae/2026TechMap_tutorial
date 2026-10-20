import SwiftUI

struct GameCompleteView: View {
    let finalScore: Int
    let onStartNewGame: () -> Void

    var body: some View {
        VStack(spacing: 10) {
            Text("Game Complete")
                .font(.headline)
            Text("Final Score: \(finalScore)")
                .fontWeight(.bold)
            Button("Start New Game", action: onStartNewGame)
        }
        .frame(maxWidth: .infinity)
    }
}
