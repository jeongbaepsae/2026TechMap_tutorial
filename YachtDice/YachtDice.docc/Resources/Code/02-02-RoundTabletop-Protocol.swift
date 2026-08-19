import RealityKit
import TabletopKit

struct RoundTabletop: EntityTabletop {
    let entity: Entity
    let shape: TabletopShape
    var id: EquipmentIdentifier { .tableID }
}
