enum Section { case upper, lower }

var section: Section {
    switch self {
    case .aces, .deuces, .threes, .fours, .fives, .sixes:
        .upper
    default:
        .lower
    }
}
