import TabletopKit
internal import Spatial

final class DiceInteraction: TabletopInteraction.Delegate {
    let game: YachtGame
    let controlledDie: Die
    let extraDiceToToss: [Die]

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
        extraDiceToToss = game.dice.filter { die in
            die.id != controlledDie.id
        }
    }

    func update(interaction: TabletopInteraction) {
        switch interaction.value.phase {
        case .started:
            guard game.canStartRoll else {
                interaction.cancel()
                return
            }

            game.isRolling = true

            for (index, die) in extraDiceToToss.enumerated() {
                interaction.addAction(
                    .moveEquipment(
                        die,
                        childOf: controlledDie,
                        pose: groupedDicePoses[index]
                    )
                )
            }

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

            for die in extraDiceToToss {
                interaction.toss(
                    equipmentID: die.id,
                    as: die.tossableRepresentation
                )
            }

        case .ended:
            guard didRequestToss else {
                game.isRolling = false
                return
            }
            game.finishRoll()

        case .cancelled:
            game.isRolling = false

        default:
            break
        }
    }

    func onTossStart(
        interaction: TabletopInteraction,
        outcomes: [TabletopInteraction.TossOutcome]
    ) {
        let allTossedDice = [controlledDie] + extraDiceToToss

        for outcome in outcomes {
            guard let die = allTossedDice.first(
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

            if die.id != controlledDie.id {
                interaction.addAction(
                    .moveEquipment(
                        matching: die.id,
                        childOf: .tableID
                    )
                )
            }
        }
    }
}

private let groupedDicePoses: [TableVisualState.Pose2D] = [
    .init(position: .init(x: 0.1, z: 0), rotation: .zero),
    .init(position: .init(x: -0.1, z: 0), rotation: .zero),
    .init(position: .init(x: 0, z: 0.1), rotation: .zero),
    .init(position: .init(x: 0, z: -0.1), rotation: .zero)
]
