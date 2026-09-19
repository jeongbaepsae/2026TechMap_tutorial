import Foundation

extension YachtScoreCalculator {
    func smallStraightScore(dice: [Int]) -> Int {
        let values = Set(dice)
        let patterns: [Set<Int>] = [
            [1, 2, 3, 4],
            [2, 3, 4, 5],
            [3, 4, 5, 6]
        ]

        return patterns.contains { $0.isSubset(of: values) } ? 15 : 0
    }

    func largeStraightScore(dice: [Int]) -> Int {
        let values = Set(dice)
        let isStraight =
            values == Set([1, 2, 3, 4, 5]) ||
            values == Set([2, 3, 4, 5, 6])

        return isStraight ? 30 : 0
    }

    func yachtScore(dice: [Int]) -> Int {
        Set(dice).count == 1 ? 50 : 0
    }
}
