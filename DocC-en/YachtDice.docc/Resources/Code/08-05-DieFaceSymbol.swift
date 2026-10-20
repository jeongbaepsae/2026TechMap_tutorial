import SwiftUI

struct DieFaceSymbol: View {
    let value: Int?
    var size: CGFloat = 20
    var isHeld = false

    var body: some View {
        Image(systemName: symbolName)
            .font(.system(size: size, weight: .medium))
            .symbolRenderingMode(.hierarchical)
            .foregroundStyle(foregroundStyle)
            .opacity(isValidValue ? 1 : 0.2)
    }

    private var isValidValue: Bool {
        guard let value else {
            return false
        }
        return 1...6 ~= value
    }

    private var symbolName: String {
        guard let value,
              1...6 ~= value else {
            return "die.face.1"
        }

        return "die.face.\(value).fill"
    }

    private var foregroundStyle: Color {
        guard isValidValue else {
            return .secondary
        }

        return isHeld ? .accentColor : .primary
    }
}

struct DiceFaceSymbolsView: View {
    let values: [Int]
    var size: CGFloat = 15

    var body: some View {
        HStack(spacing: 2) {
            ForEach(Array(values.enumerated()), id: \.offset) { _, value in
                DieFaceSymbol(value: value, size: size)
                    .accessibilityHidden(true)
            }
        }
    }
}
