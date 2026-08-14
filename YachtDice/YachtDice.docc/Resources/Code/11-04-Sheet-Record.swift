mutating func record(
    category: YachtCategory,
    score: Int,
    dice: [Int]
) -> Bool {
    guard !contains(category) else { return false }

    entries[category] = YachtScoreEntry(
        category: category,
        score: score,
        dice: dice
    )
    return true
}
