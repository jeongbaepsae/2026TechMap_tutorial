import SwiftUI

struct NumbersBonusView: View {
    let scoreSheet: YachtScoreSheet

    var body: some View {
        VStack(spacing: 8) {
            HStack {
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
                NumbersBonusStatusView(scoreSheet: scoreSheet)
            }

            ProgressView(
                value: Double(min(scoreSheet.numbersScore, YachtBonusRule.targetScore)),
                total: Double(YachtBonusRule.targetScore)
            )
        }
        .padding(10)
        .background(
            .regularMaterial,
            in: RoundedRectangle(cornerRadius: 10)
        )
    }
}
