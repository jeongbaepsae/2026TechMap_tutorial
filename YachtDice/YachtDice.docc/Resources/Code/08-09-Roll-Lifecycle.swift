case .started:
    guard game.canStartRoll else {
        interaction.cancel()
        return
    }
    game.isRolling = true

case .ended:
    guard didRequestToss else {
        game.isRolling = false
        return
    }
    game.finishRoll()
