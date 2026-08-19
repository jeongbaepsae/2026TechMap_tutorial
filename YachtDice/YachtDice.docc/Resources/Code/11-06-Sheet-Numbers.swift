var numbersScore: Int {
    entries.values
        .filter { $0.category.section == .upper }
        .reduce(0) { $0 + $1.score }
}
