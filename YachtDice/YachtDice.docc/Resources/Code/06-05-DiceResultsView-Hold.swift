import SwiftUI

struct DiceResultsView: View {
    let results: [Int]
    let totalScore: Int?
    let heldIndices: Set<Int>
    let canSelectDice: Bool
    let rollCount: Int
    let maximumRollCount: Int
    let isRolling: Bool
    let isGameFinished: Bool
    let onTapDie: (Int) -> Void

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("Dice")
                    .font(.headline)
                Spacer()
                Text("Roll \(rollCount) / \(maximumRollCount)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 14) {
                ForEach(0..<5, id: \.self) { index in
                    dieButton(at: index)
                }
            }

            Divider()

            HStack {
                Text("Total")
                    .foregroundStyle(.secondary)
                Spacer()
                Text(totalScore.map(String.init) ?? "–")
                    .fontWeight(.bold)
            }

            if rollCount >= maximumRollCount && !isGameFinished {
                Label(
                    "Choose a score category",
                    systemImage: "list.bullet.clipboard"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
        .padding(20)
        .frame(width: 420)
        .glassBackgroundEffect()
    }

    private func dieButton(at index: Int) -> some View {
        let isHeld = heldIndices.contains(index)
        let hasResult = results.indices.contains(index)

        return Button {
            onTapDie(index)
        } label: {
            ZStack(alignment: .topTrailing) {
                Text(hasResult ? String(results[index]) : "–")
                    .font(.title2)
                    .frame(width: 48, height: 48)
                    .background(
                        isHeld
                            ? Color.accentColor.opacity(0.25)
                            : Color.clear,
                        in: RoundedRectangle(cornerRadius: 10)
                    )

                if isHeld {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .padding(4)
                        .background(.regularMaterial, in: Circle())
                        .offset(x: 4, y: -4)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(
            !canSelectDice ||
            !hasResult ||
            isRolling ||
            isGameFinished
        )
    }
}
