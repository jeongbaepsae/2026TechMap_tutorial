import SwiftUI

struct DiceResultsView: View {
    let results: [Int]
    let totalScore: Int?
    let heldIndices: Set<Int>
    let canSelectDice: Bool
    let rollCount: Int
    let maximumRollCount: Int
    let isRolling: Bool
    let onTapDie: (Int) -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Dice").font(.headline)
                Spacer()
                Text("Roll \(rollCount) / \(maximumRollCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 14) {
                ForEach(0..<5, id: \.self) { index in
                    let hasResult = results.indices.contains(index)
                    DieResultButton(
                        value: hasResult ? results[index] : nil,
                        isHeld: heldIndices.contains(index),
                        isEnabled: canSelectDice && hasResult && !isRolling
                    ) {
                        onTapDie(index)
                    }
                }
            }

            Divider()

            HStack {
                Text("Total").foregroundStyle(.secondary)
                Spacer()
                Text(totalScore.map(String.init) ?? "–")
                    .fontWeight(.bold)
            }
        }
        .padding(20)
        .frame(width: 420)
        .glassBackgroundEffect()
    }
}
