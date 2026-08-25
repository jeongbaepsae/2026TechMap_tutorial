//
//  YachtCategory.swift
//  YachtDice
//
//  Created by 김한슬 on 8/7/26.
//

import Foundation

enum YachtCategory: String, CaseIterable, Identifiable, Hashable {
    case aces
    case deuces
    case threes
    case fours
    case fives
    case sixes

    case choice
    case fourOfAKind
    case fullHouse
    case smallStraight
    case largeStraight
    case yacht

    var id: Self {
        self
    }

    var title: String {
        switch self {
        case .aces:
            "Aces"
        case .deuces:
            "Deuces"
        case .threes:
            "Threes"
        case .fours:
            "Fours"
        case .fives:
            "Fives"
        case .sixes:
            "Sixes"
        case .choice:
            "Choice"
        case .fourOfAKind:
            "Four of a Kind"
        case .fullHouse:
            "Full House"
        case .smallStraight:
            "Small Straight"
        case .largeStraight:
            "Large Straight"
        case .yacht:
            "Yacht"
        }
    }

    var targetFace: Int? {
        switch self {
        case .aces:
            1
        case .deuces:
            2
        case .threes:
            3
        case .fours:
            4
        case .fives:
            5
        case .sixes:
            6
        default:
            nil
        }
    }

    var section: Section {
        switch self {
        case .aces, .deuces, .threes, .fours, .fives, .sixes:
            .upper
        default:
            .lower
        }
    }
}

extension YachtCategory {
    enum Section {
        case upper
        case lower
    }
}
