import TabletopKit
internal import Spatial

extension DiceInteraction {
    func update(interaction: TabletopInteraction) {
        switch interaction.value.phase {
        case .started:
            guard game.canStartRoll else {
                interaction.cancel()
                return
            }

            game.isRolling = true
            groupDice(interaction: interaction)

        case .update:
            guard interaction.value.gesture?.phase == .ended,
                  !didRequestToss else {
                return
            }

            didRequestToss = true
            requestToss(interaction: interaction)

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

    private func groupDice(interaction: TabletopInteraction) {
        for (index, die) in extraDiceToToss.enumerated() {
            interaction.addAction(
                .moveEquipment(
                    die,
                    childOf: controlledDie,
                    pose: groupedDicePoses[index]
                )
            )
        }
    }

    private func requestToss(interaction: TabletopInteraction) {
        for die in [controlledDie] + extraDiceToToss {
            interaction.toss(
                equipmentID: die.id,
                as: die.tossableRepresentation
            )
        }
    }
}

private let groupedDicePoses: [TableVisualState.Pose2D] = [
    .init(position: .init(x: 0.1, z: 0), rotation: .zero),
    .init(position: .init(x: -0.1, z: 0), rotation: .zero),
    .init(position: .init(x: 0, z: 0.1), rotation: .zero),
    .init(position: .init(x: 0, z: -0.1), rotation: .zero)
]
