.ornament(
    attachmentAnchor: .scene(.bottomFront),
    contentAlignment: .top
) {
    DiceResultsView(
        results: game.lastRollResults,
        totalScore: game.lastRollScore,
        rollCount: game.rollCount
    )
}
