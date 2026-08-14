struct DiceResultsView: View {
    let results: [Int]
    let totalScore: Int
    let rollCount: Int

    var body: some View {
        VStack {
            Text("Roll \(rollCount) / 3")

            HStack {
                ForEach(results.indices, id: \.self) { index in
                    DieFaceSymbol(value: results[index])
                }
            }

            Text("Total \(totalScore)")
        }
    }
}
