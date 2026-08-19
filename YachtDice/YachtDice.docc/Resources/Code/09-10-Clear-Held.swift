private func clearHeldDice() {
    for die in dice {
        die.setHeldAppearance(false)
    }

    heldDieIDs.removeAll()
}
