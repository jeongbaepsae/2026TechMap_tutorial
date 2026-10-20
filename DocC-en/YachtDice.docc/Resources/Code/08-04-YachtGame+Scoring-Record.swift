extension YachtGame {
    var canCommitScore: Bool {
        hasRolled && !isRolling
    }

    var yachtScorePreviews: [YachtCategory: Int] {
        guard hasRolled else { return [:] }
        return scoreCalculator.scores(for: lastRollResults)
    }

    @discardableResult
    func commitScore(for category: YachtCategory) -> Bool {
        guard canCommitScore else { return false }

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

        resetTurnState()
        return true
    }

    private func resetTurnState() {
        rollCount = 0
        heldDieIDs.removeAll()
        isRolling = false
        lastRollResults = []
        for die in dice { die.setHeldAppearance(false) }
    }
}
