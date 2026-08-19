func toggleHold(at index: Int) {
    guard canToggleHold, dice.indices.contains(index) else { return }

    let die = dice[index]
    let shouldHold = !isHeld(die)

    if shouldHold {
        heldDieIDs.insert(die.id)
    } else {
        heldDieIDs.remove(die.id)
    }
}
