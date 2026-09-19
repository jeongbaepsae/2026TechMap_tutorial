import SwiftUI

struct YachtRecordedScoreRow: View {
    let category: YachtCategory
    let entry: YachtScoreEntry

    var body: some View {
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
        .accessibilityLabel(
            "\(category.title), dice \(diceText), score \(entry.score)"
        )
    }

    private var diceText: String {
        entry.dice.map(String.init).joined(separator: ", ")
    }
}
