extension YachtScoreSheet {
    var numbersScore: Int {
        entries.values
            .filter { $0.category.section == .upper }
            .map(\.score)
            .reduce(0, +)
    }

    var remainingNumbersScoreForBonus: Int {
        max(0, YachtBonusRule.targetScore - numbersScore)
    }

    var hasNumbersBonus: Bool {
        numbersScore >= YachtBonusRule.targetScore
    }

    var isNumbersSectionComplete: Bool {
        YachtCategory.allCases
            .filter { $0.section == .upper }
            .allSatisfy { entries[$0] != nil }
    }

    var numbersBonusScore: Int {
        hasNumbersBonus ? YachtBonusRule.bonusScore : 0
    }
}
