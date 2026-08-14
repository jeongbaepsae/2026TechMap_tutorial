func finishRoll() {
    guard rollCount < Self.maximumRollCount else {
        isRolling = false
        return
    }

    updateDiceResults()
    rollCount += 1
    isRolling = false
}
