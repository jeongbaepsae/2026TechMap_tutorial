import SwiftUI

struct DiceResultsView: View {
    let results: [Int]
    let totalScore: Int?
    let rollCount: Int
    let maximumRollCount: Int

    var body: some View {
        VStack(spacing: 12) {
            Text("Roll \(rollCount) / \(maximumRollCount)")
                .font(.headline)

            HStack(spacing: 14) {
                ForEach(0..<5, id: \.self) { index in
                    Text(resultText(at: index))
                        .font(.title2)
                        .frame(width: 48, height: 48)
                        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 10))
                }
            }

            Text("Total: \(totalScore.map(String.init) ?? "–")")
                .font(.subheadline)
        }
        .padding(20)
        .glassBackgroundEffect()
    }

    private func resultText(at index: Int) -> String {
        guard results.indices.contains(index) else {
            return "–"
        }
        return String(results[index])
    }
}
