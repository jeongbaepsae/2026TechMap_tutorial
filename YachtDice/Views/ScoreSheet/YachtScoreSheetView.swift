import SwiftUI

struct YachtScoreSheetView: View {
    let scoreSheet: YachtScoreSheet
    let previews: [YachtCategory: Int]
    let canCommitScore: Bool
    let onSelectCategory: (YachtCategory) -> Void
    let onStartNewGame: () -> Void

    private var upperCategories: [YachtCategory] {
        YachtCategory.allCases.filter { $0.section == .upper }
    }

    private var lowerCategories: [YachtCategory] {
        YachtCategory.allCases.filter { $0.section == .lower }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            header

            HStack(alignment: .top, spacing: 20) {
                numbersSection

                Divider()

                YachtScoreSectionView(
                    title: "Combinations",
                    categories: lowerCategories,
                    scoreSheet: scoreSheet,
                    previews: previews,
                    canCommitScore: canCommitScore,
                    onSelectCategory: onSelectCategory
                )
                .frame(maxWidth: .infinity, alignment: .topLeading)
            }

            Divider()

            totalSection

            if scoreSheet.isComplete {
                gameFinishedSection
            }
        }
        .padding(20)
        .frame(width: 680)
        .glassBackgroundEffect()
    }

    private var header: some View {
        HStack {
            Text("Yacht Score Sheet")
                .font(.headline)

            Spacer()

            Text("\(scoreSheet.entries.count) / \(YachtCategory.allCases.count)")
                .font(.subheadline)
                .fontWeight(.semibold)
                .monospacedDigit()
                .foregroundStyle(.secondary)
        }
    }

    private var numbersSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            YachtScoreSectionView(
                title: "Numbers",
                categories: upperCategories,
                scoreSheet: scoreSheet,
                previews: previews,
                canCommitScore: canCommitScore,
                onSelectCategory: onSelectCategory
            )

            NumbersBonusView(scoreSheet: scoreSheet)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }

    private var totalSection: some View {
        VStack(spacing: 8) {
            if scoreSheet.numbersBonusScore > 0 {
                HStack {
                    Label(
                        "Numbers Bonus",
                        systemImage: "sparkles"
                    )
                    .font(.caption)
                    .foregroundStyle(.secondary)

                    Spacer()

                    Text("+\(scoreSheet.numbersBonusScore)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.accentColor)
                        .monospacedDigit()
                }
            }

            HStack {
                Text("Total Score")
                    .font(.headline)

                Spacer()

                Text("\(scoreSheet.totalScore)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .monospacedDigit()
            }
        }
    }

    private var gameFinishedSection: some View {
        VStack(spacing: 12) {
            Label(
                "Game Complete",
                systemImage: "flag.checkered"
            )
            .font(.headline)

            Text("Final Score: \(scoreSheet.totalScore)")
                .font(.title3)
                .fontWeight(.bold)
                .monospacedDigit()

            Button {
                onStartNewGame()
            } label: {
                Label(
                    "Start New Game",
                    systemImage: "arrow.counterclockwise"
                )
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 4)
    }
}
