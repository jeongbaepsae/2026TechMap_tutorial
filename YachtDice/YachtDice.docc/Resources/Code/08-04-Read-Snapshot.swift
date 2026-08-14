func updateDiceResults() {
    tabletopGame.withCurrentSnapshot { snapshot in
        lastRollResults = dice.map { die in
            die.calculateScore(
                for: snapshot.state(for: die)
            )
        }
    }
}
