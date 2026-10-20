import SwiftUI

struct NumbersBonusStatusView: View {
    let scoreSheet: YachtScoreSheet

    var body: some View {
        if scoreSheet.hasNumbersBonus {
            Label(
                "+\(YachtBonusRule.bonusScore)",
                systemImage: "checkmark.circle.fill"
            )
            .font(.caption)
            .fontWeight(.bold)
            .foregroundStyle(Color.accentColor)

        } else if scoreSheet.isNumbersSectionComplete {
            Text("Not earned")
                .font(.caption)
                .foregroundStyle(.secondary)

        } else {
            VStack(alignment: .trailing, spacing: 2) {
                Text("\(scoreSheet.remainingNumbersScoreForBonus) pts left")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .monospacedDigit()

                Text("+\(YachtBonusRule.bonusScore) Bonus")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
