struct DieFaceSymbol: View {
    let value: Int

    var body: some View {
        Image(systemName: "die.face.\(value).fill")
            .symbolRenderingMode(.hierarchical)
    }
}
