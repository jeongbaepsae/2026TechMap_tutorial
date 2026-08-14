import SwiftUI

struct YachtScoreRow: View {
    let category: YachtCategory
    let entry: YachtScoreEntry?
    let previewScore: Int?
    let canCommitScore: Bool
    let onSelectCategory: (YachtCategory) -> Void

    var body: some View {
        if let entry {
            recordedRow(entry)
        } else {
            availableRow
        }
    }

    private func recordedRow(_ entry: YachtScoreEntry) -> some View {
        HStack(spacing: 10) {
            Text(category.title)
                .font(.subheadline)
                .lineLimit(1)

            Spacer(minLength: 8)

            DiceFaceSymbolsView(values: entry.dice)

            Text("\(entry.score)")
                .font(.subheadline)
                .fontWeight(.bold)
                .monospacedDigit()
                .frame(minWidth: 28, alignment: .trailing)
        }
        .padding(.horizontal, 10)
        .frame(height: 38)
        .background(
            .regularMaterial,
            in: RoundedRectangle(cornerRadius: 10)
        )
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel(for: entry))
    }

    private var availableRow: some View {
        Button {
            onSelectCategory(category)
        } label: {
            HStack(spacing: 10) {
                Text(category.title)
                    .font(.subheadline)
                    .lineLimit(1)

                Spacer()

                Text(previewScore.map(String.init) ?? "–")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .monospacedDigit()
                    .frame(minWidth: 28, alignment: .trailing)
            }
            .padding(.horizontal, 10)
            .frame(height: 38)
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
        .background(
            canCommitScore
                ? Color.accentColor.opacity(0.12)
                : Color.clear,
            in: RoundedRectangle(cornerRadius: 10)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    canCommitScore
                        ? Color.accentColor.opacity(0.5)
                        : Color.secondary.opacity(0.15),
                    lineWidth: 1
                )
        }
        .disabled(!canCommitScore)
    }

    private func accessibilityLabel(for entry: YachtScoreEntry) -> String {
        let diceText = entry.dice
            .map(String.init)
            .joined(separator: ", ")

        return "\(category.title), dice \(diceText), score \(entry.score)"
    }
}
