import SwiftUI
import RealityKit
import TabletopKit

@Observable
final class YachtGame {
    static let maximumRollCount = 3

    let root = Entity()
    let tabletopGame: TabletopGame
    let dice: [Die]

    private let scoreCalculator = YachtScoreCalculator()

    private(set) var lastRollResults: [Int] = []
    private(set) var heldDieIDs: Set<EquipmentIdentifier> = []
    private(set) var rollCount = 0
    var isRolling = false

    @MainActor
    init() {
        root.name = "Yacht game root"
        let tabletop = RoundTabletop()
        let createdDice = (1...5).map { Die(index: $0) }
        dice = createdDice

        var setup = TableSetup(tabletop: tabletop)
        setup.add(
            seat: PlayerSeat(
                index: 0,
                position: .init(x: 0, z: 0.5),
                rotation: .init(degrees: 0)
            )
        )
        for die in createdDice { setup.add(equipment: die) }

        tabletopGame = TabletopGame(tableSetup: setup)
        tabletopGame.claimAnySeat()
    }

    var lastRollScore: Int { lastRollResults.reduce(0, +) }
    var hasRolled: Bool { lastRollResults.count == dice.count }
    var rollableDice: [Die] { dice.filter { !heldDieIDs.contains($0.id) } }
    var heldDieIndices: Set<Int> { Set(dice.indices.filter { heldDieIDs.contains(dice[$0].id) }) }
    var canStartRoll: Bool { !isRolling && rollCount < Self.maximumRollCount && !rollableDice.isEmpty }
    var canToggleHold: Bool { hasRolled && !isRolling && rollCount < Self.maximumRollCount }

    var yachtScorePreviews: [YachtCategory: Int] {
        guard hasRolled else { return [:] }
        return scoreCalculator.scores(for: lastRollResults)
    }

    func isHeld(_ die: Die) -> Bool { heldDieIDs.contains(die.id) }

    func toggleHold(at index: Int) {
        guard canToggleHold, dice.indices.contains(index) else { return }
        let die = dice[index]
        let shouldHold = !isHeld(die)
        if shouldHold { heldDieIDs.insert(die.id) }
        else { heldDieIDs.remove(die.id) }
        die.setHeldAppearance(shouldHold)
    }

    func repositionTable(content: RealityViewContent, proxy: GeometryProxy3D) {
        let frame = content.convert(proxy.frame(in: .global), from: .global, to: .scene)
        root.transform.translation = .init(x: 0, y: frame.min.y, z: 0)
    }

    func updateDiceResults() {
        tabletopGame.withCurrentSnapshot { snapshot in
            lastRollResults = dice.map { die in
                die.calculateScore(for: snapshot.state(for: die))
            }
        }
    }

    func finishRoll() {
        guard rollCount < Self.maximumRollCount else { isRolling = false; return }
        updateDiceResults()
        rollCount += 1
        isRolling = false
    }
}
