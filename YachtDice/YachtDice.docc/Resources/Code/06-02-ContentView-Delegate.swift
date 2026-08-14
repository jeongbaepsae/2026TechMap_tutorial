.tabletopGame(game.tabletopGame, parent: game.root) { initialValue in
    DiceInteraction(
        game: game,
        initialInteractionValue: initialValue
    )
}
