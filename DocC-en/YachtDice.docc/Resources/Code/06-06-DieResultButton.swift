import SwiftUI

struct DieResultButton: View {
    let value: Int?
    let isHeld: Bool
    let isEnabled: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack(alignment: .topTrailing) {
                Text(value.map(String.init) ?? "–")
                    .font(.title2)
                    .frame(width: 48, height: 48)
                    .background(
                        isHeld ? Color.accentColor.opacity(0.25) : .clear,
                        in: RoundedRectangle(cornerRadius: 10)
                    )

                if isHeld {
                    Image(systemName: "lock.fill")
                        .font(.caption2)
                        .padding(4)
                        .background(.regularMaterial, in: Circle())
                        .offset(x: 4, y: -4)
                }
            }
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
    }
}
