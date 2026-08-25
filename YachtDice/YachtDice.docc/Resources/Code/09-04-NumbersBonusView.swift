import SwiftUI

struct NumbersBonusView: View {
    let scoreSheet: YachtScoreSheet

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Numbers Bonus")
                        .font(.caption)
                        .fontWeight(.semibold)

                    Text("\(scoreSheet.numbersScore) / \(YachtBonusRule.targetScore)")
                        .font(.caption)
                        .monospacedDigit()
                        .foregroundStyle(.secondary)
                }

                Spacer()

                bonusStatus
            }

            ProgressView(
                value: Double(
                    min(
                        scoreSheet.numbersScore,
                        YachtBonusRule.targetScore
                    )
                ),
                total: Double(YachtBonusRule.targetScore)
            )
        }
        .padding(10)
        .background(
            .regularMaterial,
            in: RoundedRectangle(cornerRadius: 10)
        )
    }

    @ViewBuilder
    private var bonusStatus: some View {
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
