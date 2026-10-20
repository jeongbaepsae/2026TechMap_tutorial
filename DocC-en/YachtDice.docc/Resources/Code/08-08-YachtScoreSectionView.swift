import SwiftUI

struct YachtScoreSectionView: View {
    let title: String
    let categories: [YachtCategory]
    let scoreSheet: YachtScoreSheet
    let previews: [YachtCategory: Int]
    let canCommitScore: Bool
    let onSelectCategory: (YachtCategory) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            ForEach(categories) { category in
                YachtScoreRow(
                    category: category,
                    entry: scoreSheet.entries[category],
                    previewScore: previews[category],
                    canCommitScore: canCommitScore,
                    onSelectCategory: onSelectCategory
                )
            }
        }
    }
}
