/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A container that coordinates the tabletop, turn state, and Yacht scoring.
*/
import SwiftUI
import RealityKit
import TabletopKit

@Observable
final class YachtGame {
    static let maximumRollCount = 3

    let tabletopGame: TabletopGame
    let root = Entity()
    let dice: [Die]

    private let scoreCalculator = YachtScoreCalculator()

    private(set) var scoreSheet = YachtScoreSheet()
    private(set) var lastRollResults: [Int] = []
    private(set) var heldDieIDs: Set<EquipmentIdentifier> = []
    private(set) var rollCount = 0

    var isRolling = false

    @MainActor
    init() {
        root.name = "Yacht game root"

        let tabletop = RoundTabletop()
        let createdDice = (1...5).map { cubeDie(index: $0) }
        dice = createdDice

        var setup = TableSetup(tabletop: tabletop)
        setup.add(
            seat: PlayerSeat(
                index: 0,
                position: .init(x: 0, z: 0.5),
                rotation: .init(degrees: 0)
            )
        )

        for die in createdDice {
            setup.add(equipment: die)
        }

        tabletopGame = TabletopGame(tableSetup: setup)
        tabletopGame.claimAnySeat()
    }

    var lastRollScore: Int {
        lastRollResults.reduce(0, +)
    }

    var hasRolled: Bool {
        lastRollResults.count == dice.count
    }

    var rollableDice: [Die] {
        dice.filter { !heldDieIDs.contains($0.id) }
    }

    var heldDieIndices: Set<Int> {
        Set(
            dice.indices.filter { index in
                heldDieIDs.contains(dice[index].id)
            }
        )
    }

    var canStartRoll: Bool {
        !isRolling &&
        !isGameFinished &&
        rollCount < Self.maximumRollCount &&
        !rollableDice.isEmpty
    }

    var canToggleHold: Bool {
        hasRolled &&
        !isRolling &&
        !isGameFinished &&
        rollCount < Self.maximumRollCount
    }

    var canCommitScore: Bool {
        hasRolled &&
        !isRolling &&
        !isGameFinished
    }

    var yachtScorePreviews: [YachtCategory: Int] {
        guard hasRolled else {
            return [:]
        }

        return scoreCalculator.scores(for: lastRollResults)
    }

    var isGameFinished: Bool {
        scoreSheet.isComplete
    }

    func isHeld(_ die: Die) -> Bool {
        heldDieIDs.contains(die.id)
    }

    func toggleHold(at index: Int) {
        guard canToggleHold,
              dice.indices.contains(index) else {
            return
        }

        let die = dice[index]
        let shouldHold = !isHeld(die)

        if shouldHold {
            heldDieIDs.insert(die.id)
        } else {
            heldDieIDs.remove(die.id)
        }

        die.setHeldAppearance(shouldHold)
    }

    func repositionTable(
        content: RealityViewContent,
        proxy: GeometryProxy3D
    ) {
        let frame = content.convert(
            proxy.frame(in: .global),
            from: .global,
            to: .scene
        )

        root.transform.translation = .init(
            x: 0,
            y: frame.min.y,
            z: 0
        )
    }

    func updateDiceResults() {
        tabletopGame.withCurrentSnapshot { snapshot in
            lastRollResults = dice.map { die in
                die.calculateScore(for: snapshot.state(for: die))
            }
        }
    }

    func finishRoll() {
        guard rollCount < Self.maximumRollCount else {
            isRolling = false
            return
        }

        updateDiceResults()
        rollCount += 1
        isRolling = false
    }

    func startNewGame() {
        guard !isRolling else {
            return
        }

        scoreSheet.reset()
        resetTurnState()
    }

    @discardableResult
    func commitScore(for category: YachtCategory) -> Bool {
        guard canCommitScore else {
            return false
        }

        let score = scoreCalculator.score(
            dice: lastRollResults,
            category: category
        )

        guard scoreSheet.record(
            category: category,
            score: score,
            dice: lastRollResults
        ) else {
            return false
        }

        if isGameFinished {
            clearHeldDice()
        } else {
            resetTurnState()
        }

        return true
    }

    private func resetTurnState() {
        rollCount = 0
        clearHeldDice()
        isRolling = false
        lastRollResults = []
    }

    private func clearHeldDice() {
        for die in dice {
            die.setHeldAppearance(false)
        }

        heldDieIDs.removeAll()
    }
}
