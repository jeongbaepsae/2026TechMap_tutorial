import TabletopKit

extension YachtGame {
    var lastRollScore: Int {
        lastRollResults.reduce(0, +)
    }

    var canStartRoll: Bool {
        !isRolling && rollCount < Self.maximumRollCount
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
