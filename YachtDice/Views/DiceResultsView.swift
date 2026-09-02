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

    private let diceCount = 5

    var body: some View {
        VStack(spacing: 16) {
            header
            diceRow
            Divider()
            footer
        }
        .padding(20)
        .frame(width: 420)
        .glassBackgroundEffect()
    }

    private var header: some View {
        HStack {
            Text("Dice")
                .font(.headline)

            Spacer()

            Text("Roll \(rollCount) / \(maximumRollCount)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .monospacedDigit()
                .foregroundStyle(.secondary)
        }
    }

    private var diceRow: some View {
        HStack(spacing: 14) {
            ForEach(0..<diceCount, id: \.self) { index in
                dieButton(at: index)
            }
        }
    }

    private var footer: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Total")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Spacer()

                Text(totalScoreText)
                    .font(.title3)
                    .fontWeight(.bold)
                    .monospacedDigit()
            }

            if shouldShowScoreGuide {
                Label(
                    "Choose a score category",
                    systemImage: "list.bullet.clipboard"
                )
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }

    private func dieButton(at index: Int) -> some View {
        let isHeld = heldIndices.contains(index)
        let value = dieValue(at: index)

        return Button {
            onTapDie(index)
        } label: {
            ZStack(alignment: .topTrailing) {
                DieFaceSymbol(
                    value: value,
                    size: 44,
                    isHeld: isHeld
                )

                if isHeld {
                    holdBadge
                }
            }
            .frame(width: 56, height: 56)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .disabled(
            !canSelectDice ||
            value == nil ||
            isRolling ||
            isGameFinished
        )
        .accessibilityLabel(
            accessibilityLabel(
                at: index,
                value: value,
                isHeld: isHeld
            )
        )
    }

    private var holdBadge: some View {
        Image(systemName: "lock.fill")
            .font(.system(size: 9, weight: .bold))
            .foregroundStyle(.white)
            .padding(5)
            .background(Color.accentColor, in: Circle())
            .offset(x: 4, y: -4)
    }

    private var totalScoreText: String {
        guard !results.isEmpty,
              let totalScore else {
            return "–"
        }

        return String(totalScore)
    }

    private var shouldShowScoreGuide: Bool {
        rollCount >= maximumRollCount && !isGameFinished
    }

    private func dieValue(at index: Int) -> Int? {
        guard results.indices.contains(index) else {
            return nil
        }

        let value = results[index]
        return 1...6 ~= value ? value : nil
    }

    private func accessibilityLabel(
        at index: Int,
        value: Int?,
        isHeld: Bool
    ) -> String {
        guard let value else {
            return "Die \(index + 1), not rolled"
        }

        return isHeld
            ? "Die \(index + 1), \(value), held"
            : "Die \(index + 1), \(value)"
    }
}

#Preview {
    DiceResultsView(
        results: [2, 5, 3, 3, 6],
        totalScore: 19,
        heldIndices: [1, 3],
        canSelectDice: true,
        rollCount: 2,
        maximumRollCount: 3,
        isRolling: false,
        isGameFinished: false,
        onTapDie: { index in
            print("Tapped die \(index)")
        }
    )
    .padding()
}
