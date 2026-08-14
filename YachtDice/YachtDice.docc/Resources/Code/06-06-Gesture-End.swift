case .update:
    guard interaction.value.gesture?.phase == .ended else {
        return
    }
