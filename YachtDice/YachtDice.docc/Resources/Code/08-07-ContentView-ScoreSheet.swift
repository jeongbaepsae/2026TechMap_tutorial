import SwiftUI
import RealityKit
import TabletopKit

struct ContentView: View {
    @Environment(YachtGame.self) private var game

    var body: some View {
        GeometryReader3D { proxy3D in
            RealityView { content in
                content.add(game.root)
                game.repositionTable(content: content, proxy: proxy3D)
            } update: { content in
                game.repositionTable(content: content, proxy: proxy3D)
            }
        }
        .tabletopGame(game.tabletopGame, parent: game.root) { initialInteractionValue in
            DiceInteraction(game: game, initialInteractionValue: initialInteractionValue)
        }
        .ornament(
            attachmentAnchor: .scene(.bottomBack),
            contentAlignment: .bottom
        ) {
            YachtScoreSheetView(
                scoreSheet: game.scoreSheet,
                previews: game.yachtScorePreviews,
                canCommitScore: game.canCommitScore,
                onSelectCategory: { category in
                    game.commitScore(for: category)
                }
            )
        }
        .ornament(
            attachmentAnchor: .scene(.bottomFront),
            contentAlignment: .top
        ) {
            DiceResultsView(
                results: game.lastRollResults,
                totalScore: game.lastRollResults.isEmpty ? nil : game.lastRollScore,
                heldIndices: game.heldDieIndices,
                canSelectDice: game.canToggleHold,
                rollCount: game.rollCount,
                maximumRollCount: YachtGame.maximumRollCount,
                isRolling: game.isRolling,
                isGameFinished: false,
                onTapDie: { game.toggleHold(at: $0) }
            )
        }
    }
}
