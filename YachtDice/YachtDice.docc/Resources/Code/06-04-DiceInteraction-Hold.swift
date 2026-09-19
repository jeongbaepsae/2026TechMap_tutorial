import TabletopKit

final class DiceInteraction: TabletopInteraction.Delegate {
    let game: YachtGame
    let controlledDie: Die
    let extraDiceToToss: [Die]

    var didRequestToss = false

    init(
        game: YachtGame,
        initialInteractionValue: TabletopInteraction.Value
    ) {
        self.game = game

        let selectedDie = game.tabletopGame.equipment(
            of: Die.self,
            matching: initialInteractionValue.controlledEquipmentID
        )!

        controlledDie = selectedDie
        extraDiceToToss = game.rollableDice.filter { die in
            die.id != selectedDie.id
        }
    }
}
