import SwiftUI

struct YachtScoreSheetView: View {
    let scoreSheet: YachtScoreSheet
    let previews: [YachtCategory: Int]
    let canCommitScore: Bool
    let onSelectCategory: (YachtCategory) -> Void

    private var upperCategories: [YachtCategory] {
        YachtCategory.allCases.filter { $0.section == .upper }
    }

    private var lowerCategories: [YachtCategory] {
        YachtCategory.allCases.filter { $0.section == .lower }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Yacht Score Sheet")
                .font(.headline)

            HStack(alignment: .top, spacing: 20) {
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

                Divider()

                YachtScoreSectionView(
                    title: "Combinations",
                    categories: lowerCategories,
                    scoreSheet: scoreSheet,
                    previews: previews,
                    canCommitScore: canCommitScore,
                    onSelectCategory: onSelectCategory
                )
            }

            Divider()

            HStack {
                Text("Total Score")
                Spacer()
                Text("\(scoreSheet.totalScore)")
                    .fontWeight(.bold)
            }
        }
        .padding(20)
        .frame(width: 680)
        .glassBackgroundEffect()
    }
}
