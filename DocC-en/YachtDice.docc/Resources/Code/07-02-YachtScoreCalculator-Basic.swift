import Foundation

struct YachtScoreCalculator {
    func score(
        dice: [Int],
        category: YachtCategory
    ) -> Int {
        guard dice.count == 5,
              dice.allSatisfy({ 1...6 ~= $0 }) else {
            return 0
        }

        if let targetFace = category.targetFace {
            return dice
                .filter { $0 == targetFace }
                .reduce(0, +)
        }

        switch category {
        case .choice:
            return dice.reduce(0, +)
        default:
            return 0
        }
    }
}
