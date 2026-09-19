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
            return dice.filter { $0 == targetFace }.reduce(0, +)
        }

        switch category {
        case .choice:
            return dice.reduce(0, +)
        case .fourOfAKind:
            return fourOfAKindScore(dice: dice)
        case .fullHouse:
            return fullHouseScore(dice: dice)
        case .smallStraight:
            return smallStraightScore(dice: dice)
        case .largeStraight:
            return largeStraightScore(dice: dice)
        case .yacht:
            return yachtScore(dice: dice)
        default:
            return 0
        }
    }

    func scores(for dice: [Int]) -> [YachtCategory: Int] {
        Dictionary(
            uniqueKeysWithValues: YachtCategory.allCases.map { category in
                (category, score(dice: dice, category: category))
            }
        )
    }

    private func fourOfAKindScore(dice: [Int]) -> Int {
        let counts = frequencyMap(for: dice)
        guard counts.values.contains(where: { $0 >= 4 }) else { return 0 }
        return dice.reduce(0, +)
    }

    private func fullHouseScore(dice: [Int]) -> Int {
        let counts = frequencyMap(for: dice).values.sorted()
        return counts == [2, 3] ? dice.reduce(0, +) : 0
    }

    private func frequencyMap(for dice: [Int]) -> [Int: Int] {
        dice.reduce(into: [:]) { counts, value in
            counts[value, default: 0] += 1
        }
    }
}
