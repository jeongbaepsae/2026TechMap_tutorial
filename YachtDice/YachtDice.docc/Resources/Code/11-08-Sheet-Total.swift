var categoryScore: Int {
    entries.values.reduce(0) { $0 + $1.score }
}

var totalScore: Int {
    categoryScore + numbersBonusScore
}
