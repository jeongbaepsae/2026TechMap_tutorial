var hasRolled: Bool {
    lastRollResults.count == dice.count
}

var canToggleHold: Bool {
    hasRolled && !isRolling && rollCount < Self.maximumRollCount
}
