HStack {
    Text(entry.category.title)
    Spacer()
    DiceFaceSymbolsView(values: entry.dice)
    Text("\(entry.score)")
        .fontWeight(.bold)
}
