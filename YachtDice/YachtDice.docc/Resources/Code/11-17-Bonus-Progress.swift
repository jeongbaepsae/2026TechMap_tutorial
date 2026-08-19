Text("\(scoreSheet.numbersScore) / \(YachtBonusRule.targetScore)")

ProgressView(
    value: Double(min(scoreSheet.numbersScore, YachtBonusRule.targetScore)),
    total: Double(YachtBonusRule.targetScore)
)
