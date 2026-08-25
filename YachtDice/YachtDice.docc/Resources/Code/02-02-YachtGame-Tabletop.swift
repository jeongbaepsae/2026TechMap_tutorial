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
}
