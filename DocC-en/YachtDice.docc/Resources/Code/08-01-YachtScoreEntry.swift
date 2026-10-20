//
//  YachtScoreEntry.swift
//  YachtDice
//
//  Created by 김한슬 on 8/7/26.
//

import Foundation

struct YachtScoreEntry: Equatable {
    let category: YachtCategory
    let score: Int

    // The results of the five dice at the time the score was recorded.
    let dice: [Int]
}
