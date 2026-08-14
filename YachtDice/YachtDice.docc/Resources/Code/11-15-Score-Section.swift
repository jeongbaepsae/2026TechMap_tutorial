ForEach(categories) { category in
    YachtScoreRow(
        category: category,
        entry: scoreSheet.entries[category],
        previewScore: previews[category],
        canCommitScore: canCommitScore,
        onSelectCategory: onSelectCategory
    )
}
