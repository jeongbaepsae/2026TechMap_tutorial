extension YachtGame {
    var isGameFinished: Bool {
        scoreSheet.isComplete
    }

    func startNewGame() {
        guard !isRolling else { return }
        scoreSheet.reset()
        resetTurnState()
    }

    func clearHeldDice() {
        for die in dice {
            die.setHeldAppearance(false)
        }
        heldDieIDs.removeAll()
    }
}
