import TabletopKit

final class DiceInteraction: TabletopInteraction.Delegate {
    let game: YachtGame
    let controlledDie: Die

    private var didRequestToss = false

    init(
        game: YachtGame,
        initialInteractionValue: TabletopInteraction.Value
    ) {
        self.game = game
        controlledDie = game.tabletopGame.equipment(
            of: Die.self,
            matching: initialInteractionValue.controlledEquipmentID
        )!
    }

    func update(interaction: TabletopInteraction) {
        switch interaction.value.phase {
        case .update:
            guard interaction.value.gesture?.phase == .ended,
                  !didRequestToss else {
                return
            }

            didRequestToss = true
            interaction.toss(
                equipmentID: controlledDie.id,
                as: controlledDie.tossableRepresentation
            )

        default:
            break
        }
    }

    func onTossStart(
        interaction: TabletopInteraction,
        outcomes: [TabletopInteraction.TossOutcome]
    ) {
        guard let outcome = outcomes.first else {
            return
        }

        let face = outcome.tossableRepresentation.face(
            for: outcome.restingOrientation
        )

        interaction.addAction(
            .updateEquipment(
                controlledDie,
                rawValue: face.rawValue,
                pose: outcome.pose
            )
        )
    }
}
