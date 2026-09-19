import Foundation

enum YachtCategory: String, CaseIterable, Identifiable, Hashable {
    case aces = "Aces"
    case deuces = "Deuces"
    case threes = "Threes"
    case fours = "Fours"
    case fives = "Fives"
    case sixes = "Sixes"
    case choice = "Choice"
    case fourOfAKind = "Four of a Kind"
    case fullHouse = "Full House"
    case smallStraight = "Small Straight"
    case largeStraight = "Large Straight"
    case yacht = "Yacht"

    var id: Self { self }
    var title: String { rawValue }

    var targetFace: Int? {
        switch self {
        case .aces: 1
        case .deuces: 2
        case .threes: 3
        case .fours: 4
        case .fives: 5
        case .sixes: 6
        default: nil
        }
    }

    var section: Section {
        targetFace == nil ? .lower : .upper
    }

    enum Section {
        case upper
        case lower
    }
}
