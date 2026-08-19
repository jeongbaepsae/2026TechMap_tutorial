//
//  YachtScoreCalculator.swift
//  YachtDice
//
//  Created by 김한슬 on 8/7/26.
//

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
        guard isValid(dice) else {
            return 0
        }

        if let targetFace = category.targetFace {
            return numberScore(
                dice: dice,
                targetFace: targetFace
            )
        }

        switch category {
        case .aces, .deuces, .threes,
             .fours, .fives, .sixes:
            return 0

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
        }
    }

    func scores(
        for dice: [Int]
    ) -> [YachtCategory: Int] {
        Dictionary(
            uniqueKeysWithValues: YachtCategory.allCases.map { category in
                (
                    category,
                    score(
                        dice: dice,
                        category: category
                    )
                )
            }
        )
    }

    private func isValid(_ dice: [Int]) -> Bool {
        dice.count == 5 &&
        dice.allSatisfy { 1...6 ~= $0 }
    }

    private func numberScore(
        dice: [Int],
        targetFace: Int
    ) -> Int {
        dice
            .filter { $0 == targetFace }
            .reduce(0, +)
    }

    private func fourOfAKindScore(
        dice: [Int]
    ) -> Int {
        let counts = frequencyMap(for: dice)

        guard counts.values.contains(where: { $0 >= 4 }) else {
            return 0
        }

        return dice.reduce(0, +)
    }

    private func fullHouseScore(
        dice: [Int]
    ) -> Int {
        let sortedCounts = frequencyMap(for: dice)
            .values
            .sorted()

        guard sortedCounts == [2, 3] else {
            return 0
        }

        return dice.reduce(0, +)
    }

    private func smallStraightScore(
        dice: [Int]
    ) -> Int {
        let uniqueValues = Set(dice)

        let straightPatterns: [Set<Int>] = [
            [1, 2, 3, 4],
            [2, 3, 4, 5],
            [3, 4, 5, 6]
        ]

        let containsStraight = straightPatterns.contains { pattern in
            pattern.isSubset(of: uniqueValues)
        }

        return containsStraight
            ? Score.smallStraight
            : 0
    }

    private func largeStraightScore(
        dice: [Int]
    ) -> Int {
        let uniqueValues = Set(dice)

        let isLargeStraight =
            uniqueValues == Set([1, 2, 3, 4, 5]) ||
            uniqueValues == Set([2, 3, 4, 5, 6])

        return isLargeStraight
            ? Score.largeStraight
            : 0
    }

    private func yachtScore(
        dice: [Int]
    ) -> Int {
        let isYacht = Set(dice).count == 1

        return isYacht
            ? Score.yacht
            : 0
    }

    private func frequencyMap(
        for dice: [Int]
    ) -> [Int: Int] {
        dice.reduce(into: [:]) { result, value in
            result[value, default: 0] += 1
        }
    }
}
