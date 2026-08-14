func isHeld(_ die: Die) -> Bool {
    heldDieIDs.contains(die.id)
}

var rollableDice: [Die] {
    dice.filter { !heldDieIDs.contains($0.id) }
}
