if scoreSheet.hasNumbersBonus {
    Label(
        "+\(YachtBonusRule.bonusScore)",
        systemImage: "checkmark.circle.fill"
    )
} else {
    Text("\(scoreSheet.remainingNumbersScoreForBonus) pts left")
    Text("+\(YachtBonusRule.bonusScore) Bonus")
}
