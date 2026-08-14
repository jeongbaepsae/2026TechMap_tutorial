HStack(alignment: .top, spacing: 20) {
    YachtScoreSectionView(
        title: "Numbers",
        categories: upperCategories,
        scoreSheet: scoreSheet,
        previews: previews,
        canCommitScore: canCommitScore,
        onSelectCategory: onSelectCategory
    )

    Divider()

    YachtScoreSectionView(
        title: "Combinations",
        categories: lowerCategories,
        scoreSheet: scoreSheet,
        previews: previews,
        canCommitScore: canCommitScore,
        onSelectCategory: onSelectCategory
    )
}
