/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The main Yacht Dice game view.
*/
import SwiftUI
import RealityKit
import TabletopKit

struct ContentView: View {
    @Environment(YachtGame.self) private var game

    var body: some View {
        GeometryReader3D { proxy3D in
            RealityView { (content: inout RealityViewContent) in
                content.entities.append(game.root)
                game.repositionTable(
                    content: content,
                    proxy: proxy3D
                )
            } update: { content in
                game.repositionTable(
                    content: content,
                    proxy: proxy3D
                )
            }
        }
        .tabletopGame(
            game.tabletopGame,
            parent: game.root
        ) { initialInteractionValue in
            DiceInteraction(
                game: game,
                initialInteractionValue: initialInteractionValue
            )
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
                },
                onStartNewGame: {
                    game.startNewGame()
                }
            )
        }
        .ornament(
            attachmentAnchor: .scene(.bottomFront),
            contentAlignment: .top
        ) {
            DiceResultsView(
                results: game.lastRollResults,
                totalScore: game.lastRollScore,
                heldIndices: game.heldDieIndices,
                canSelectDice: game.canToggleHold,
                rollCount: game.rollCount,
                maximumRollCount: YachtGame.maximumRollCount,
                isRolling: game.isRolling,
                isGameFinished: game.isGameFinished,
                onTapDie: { index in
                    game.toggleHold(at: index)
                }
            )
        }
    }
}

#Preview(windowStyle: .volumetric) {
    @Previewable @State var game = YachtGame()

    ContentView()
        .environment(game)
}
