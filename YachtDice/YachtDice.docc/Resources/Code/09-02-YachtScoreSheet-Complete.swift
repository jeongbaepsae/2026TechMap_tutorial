import Foundation

struct YachtScoreSheet {
    private(set) var entries: [YachtCategory: YachtScoreEntry] = [:]

    var categoryScore: Int {
        entries.values.reduce(0) { partialResult, entry in
            partialResult + entry.score
        }
    }

    var numbersScore: Int {
        entries.values
            .filter { $0.category.section == .upper }
            .reduce(0) { partialResult, entry in
                partialResult + entry.score
            }
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

    var totalScore: Int {
        categoryScore + numbersBonusScore
    }

    var isComplete: Bool {
        entries.count == YachtCategory.allCases.count
    }

    func contains(_ category: YachtCategory) -> Bool {
        entries[category] != nil
    }

    @discardableResult
    mutating func record(
        category: YachtCategory,
        score: Int,
        dice: [Int]
    ) -> Bool {
        guard !contains(category) else {
            return false
        }

        entries[category] = YachtScoreEntry(
            category: category,
            score: score,
            dice: dice
        )

        return true
    }

    mutating func reset() {
        entries.removeAll()
    }
}
