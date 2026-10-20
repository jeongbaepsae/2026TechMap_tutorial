import SwiftUI
import RealityKit
import TabletopKit

@Observable
final class YachtGame {
    let root = Entity()
    let tabletopGame: TabletopGame

    @MainActor
    init() {
        root.name = "Yacht game root"

        let tabletop = RoundTabletop()
        let setup = TableSetup(tabletop: tabletop)
        tabletopGame = TabletopGame(tableSetup: setup)
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
