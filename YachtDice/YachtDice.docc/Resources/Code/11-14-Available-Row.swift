Button {
    onSelectCategory(category)
} label: {
    HStack {
        Text(category.title)
        Spacer()
        Text("\(previews[category, default: 0])")
    }
}
.disabled(!canCommitScore)
