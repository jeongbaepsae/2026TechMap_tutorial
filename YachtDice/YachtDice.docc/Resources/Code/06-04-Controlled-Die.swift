let controlledDie: Die

init(game: YachtGame, initialInteractionValue: TabletopInteraction.Value) {
    self.game = game
    controlledDie = game.tabletopGame.equipment(
        of: Die.self,
        matching: initialInteractionValue.controlledEquipmentID
    )!
}
