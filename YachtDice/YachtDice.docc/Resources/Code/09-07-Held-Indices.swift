var heldDieIndices: Set<Int> {
    Set(
        dice.indices.filter { index in
            heldDieIDs.contains(dice[index].id)
        }
    )
}
