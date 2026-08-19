var yachtScorePreviews: [YachtCategory: Int] {
    guard hasRolled else { return [:] }
    return scoreCalculator.scores(for: lastRollResults)
}
