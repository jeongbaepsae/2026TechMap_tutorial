/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An object to respond to player interactions and update gameplay.
*/
import RealityKit
import TabletopKit
internal import Spatial

class DiceInteraction: TabletopInteraction.Delegate {

    let game: YachtGame

    // 사용자가 직접 집은 주사위입니다.
    var controlledDie: Die

    // controlledDie와 함께 던질 나머지 비고정 주사위입니다.
    var extraDiceToToss: [Die] = []
    
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

        // 고정되지 않은 주사위 중 직접 집은 주사위를 제외합니다.
        extraDiceToToss = game.rollableDice.filter { die in
            die.id != controlledDie.id
        }
    }

    func update(interaction: TabletopInteraction) {
        switch interaction.value.phase {
        case .started:
            // 세 번을 모두 굴렸거나, 모든 주사위가 고정된 경우입니다.
            guard game.canStartRoll else {
                game.isRolling = false
                interaction.cancel()
                return
            }

            // 고정된 주사위를 직접 잡은 경우입니다.
            guard !game.isHeld(controlledDie) else {
                game.isRolling = false
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
            guard interaction.value.gesture?.phase == .ended else {
                return
            }

            // 같은 ended 이벤트에서 toss가 중복 호출되는 것을 방지합니다.
            guard !didRequestToss else {
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
            // 실제 toss 요청이 있었을 때만 횟수를 증가시킵니다.
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
                fatalError(
                    "Outcome ID \(outcome.id) does not match any tossed die"
                )
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
                // controlledDie의 자식으로 임시 이동했던 주사위를
                // 다시 테이블 좌표계로 되돌립니다.
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
    .init(
        position: .init(x: 0.1, z: 0),
        rotation: .zero
    ),
    .init(
        position: .init(x: -0.1, z: 0),
        rotation: .zero
    ),
    .init(
        position: .init(x: 0, z: 0.1),
        rotation: .zero
    ),
    .init(
        position: .init(x: 0, z: -0.1),
        rotation: .zero
    )
]
