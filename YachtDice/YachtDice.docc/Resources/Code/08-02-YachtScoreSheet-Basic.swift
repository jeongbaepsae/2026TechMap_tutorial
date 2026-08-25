import Foundation

struct YachtScoreSheet {
    private(set) var entries: [YachtCategory: YachtScoreEntry] = [:]

    var totalScore: Int {
        entries.values.reduce(0) { total, entry in
            total + entry.score
        }
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
}
