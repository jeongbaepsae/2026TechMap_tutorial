var canStartRoll: Bool {
    !isRolling &&
    rollCount < Self.maximumRollCount
}
