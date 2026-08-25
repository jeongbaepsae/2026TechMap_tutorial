import Foundation

struct YachtScoreCalculator {
    private enum Score {
        static let smallStraight = 15
        static let largeStraight = 30
        static let yacht = 50
    }

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
        guard counts.values.contains(where: { $0 >= 4 }) else {
            return 0
        }
        return dice.reduce(0, +)
    }

    private func fullHouseScore(dice: [Int]) -> Int {
        let sortedCounts = frequencyMap(for: dice).values.sorted()
        guard sortedCounts == [2, 3] else {
            return 0
        }
        return dice.reduce(0, +)
    }

    private func smallStraightScore(dice: [Int]) -> Int {
        let values = Set(dice)
        let patterns: [Set<Int>] = [
            [1, 2, 3, 4],
            [2, 3, 4, 5],
            [3, 4, 5, 6]
        ]
        return patterns.contains(where: { $0.isSubset(of: values) })
            ? Score.smallStraight
            : 0
    }

    private func largeStraightScore(dice: [Int]) -> Int {
        let values = Set(dice)
        let isStraight =
            values == Set([1, 2, 3, 4, 5]) ||
            values == Set([2, 3, 4, 5, 6])
        return isStraight ? Score.largeStraight : 0
    }

    private func yachtScore(dice: [Int]) -> Int {
        Set(dice).count == 1 ? Score.yacht : 0
    }

    private func frequencyMap(for dice: [Int]) -> [Int: Int] {
        dice.reduce(into: [:]) { result, value in
            result[value, default: 0] += 1
        }
    }
}
