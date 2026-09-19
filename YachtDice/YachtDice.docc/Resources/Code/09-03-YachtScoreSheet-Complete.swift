import Foundation

struct YachtScoreSheet {
    private(set) var entries: [YachtCategory: YachtScoreEntry] = [:]

    var categoryScore: Int {
        entries.values.map(\.score).reduce(0, +)
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
        guard !contains(category) else { return false }
        entries[category] = .init(
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
