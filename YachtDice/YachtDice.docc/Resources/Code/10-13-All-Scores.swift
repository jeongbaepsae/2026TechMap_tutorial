func scores(for dice: [Int]) -> [YachtCategory: Int] {
    Dictionary(
        uniqueKeysWithValues: YachtCategory.allCases.map { category in
            (category, score(dice: dice, category: category))
        }
    )
}
