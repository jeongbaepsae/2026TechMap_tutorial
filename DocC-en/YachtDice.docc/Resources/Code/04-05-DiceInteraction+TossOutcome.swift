import TabletopKit

extension DiceInteraction {
    func onTossStart(
        interaction: TabletopInteraction,
        outcomes: [TabletopInteraction.TossOutcome]
    ) {
        let tossedDice = [controlledDie] + extraDiceToToss

        for outcome in outcomes {
            guard let die = tossedDice.first(
                where: { $0.id == outcome.id }
            ) else {
                continue
            }

            let face = outcome.tossableRepresentation.face(
                for: outcome.restingOrientation
            )

            interaction.addAction(
                .updateEquipment(
                    die,
                    rawValue: face.rawValue,
                    pose: outcome.pose
                )
            )

            guard die.id != controlledDie.id else { continue }
            interaction.addAction(
                .moveEquipment(
                    matching: die.id,
                    childOf: .tableID
                )
            )
        }
    }
}
