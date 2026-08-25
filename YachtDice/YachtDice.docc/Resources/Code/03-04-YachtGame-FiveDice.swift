import SwiftUI
import RealityKit
import TabletopKit

@Observable
final class YachtGame {
    let root = Entity()
    let tabletopGame: TabletopGame
    let dice: [Die]

    @MainActor
    init() {
        root.name = "Yacht game root"

        let tabletop = RoundTabletop()
        let createdDice = (1...5).map { Die(index: $0) }
        dice = createdDice

        var setup = TableSetup(tabletop: tabletop)
        setup.add(
            seat: PlayerSeat(
                index: 0,
                position: .init(x: 0, z: 0.5),
                rotation: .init(degrees: 0)
            )
        )

        for die in createdDice {
            setup.add(equipment: die)
        }

        tabletopGame = TabletopGame(tableSetup: setup)
        tabletopGame.claimAnySeat()
    }

    func repositionTable(
        content: RealityViewContent,
        proxy: GeometryProxy3D
    ) {
        let frame = content.convert(
            proxy.frame(in: .global),
            from: .global,
            to: .scene
        )

        root.transform.translation = .init(
            x: 0,
            y: frame.min.y,
            z: 0
        )
    }
}
