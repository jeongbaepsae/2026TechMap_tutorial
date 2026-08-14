case .started:
    guard !game.isHeld(controlledDie) else {
        game.isRolling = false
        interaction.cancel()
        return
    }
