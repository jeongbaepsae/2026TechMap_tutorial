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

    // 점수를 기록할 당시 주사위 5개의 결과입니다.
    let dice: [Int]
}
