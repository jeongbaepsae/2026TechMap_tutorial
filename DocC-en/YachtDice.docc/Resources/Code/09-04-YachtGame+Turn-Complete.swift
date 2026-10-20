import TabletopKit

extension YachtGame {
    var lastRollScore: Int { lastRollResults.reduce(0, +) }
    var hasRolled: Bool { lastRollResults.count == dice.count }

    var rollableDice: [Die] {
        dice.filter { !heldDieIDs.contains($0.id) }
    }

    var heldDieIndices: Set<Int> {
        Set(dice.indices.filter { heldDieIDs.contains(dice[$0].id) })
    }

    var canStartRoll: Bool {
        !isRolling && !isGameFinished &&
        rollCount < Self.maximumRollCount && !rollableDice.isEmpty
    }

    var canToggleHold: Bool {
        hasRolled && !isRolling && !isGameFinished &&
        rollCount < Self.maximumRollCount
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

    func updateDiceResults() {
        tabletopGame.withCurrentSnapshot { snapshot in
            lastRollResults = dice.map { die in
                die.dieValue(for: snapshot.state(for: die))
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
}
