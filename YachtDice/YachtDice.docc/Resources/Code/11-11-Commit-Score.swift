let score = scoreCalculator.score(
    dice: lastRollResults,
    category: category
)

guard scoreSheet.record(
    category: category,
    score: score,
    dice: lastRollResults
) else {
    return false
}
