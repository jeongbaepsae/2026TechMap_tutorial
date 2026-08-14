private var didRequestToss = false

case .update:
    guard interaction.value.gesture?.phase == .ended else { return }
    guard !didRequestToss else { return }

    didRequestToss = true
    // Request tosses here.
