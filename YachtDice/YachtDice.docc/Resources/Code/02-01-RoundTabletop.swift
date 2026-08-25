import RealityKit
import TabletopKit
import RealityKitContent

extension EquipmentIdentifier {
    static var tableID: Self { .init(0) }
}

struct RoundTabletop: EntityTabletop {
    let entity: Entity
    let id: EquipmentIdentifier = .tableID
    let shape: TabletopShape

    init() {
        entity = try! Entity.load(
            named: "table/table",
            in: realityKitContentBundle
        )
        shape = .round(entity: entity)
    }
}
