var remainingNumbersScoreForBonus: Int {
    max(0, YachtBonusRule.targetScore - numbersScore)
}

var hasNumbersBonus: Bool {
    numbersScore >= YachtBonusRule.targetScore
}

var numbersBonusScore: Int {
    hasNumbersBonus ? YachtBonusRule.bonusScore : 0
}
