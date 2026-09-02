import Spatial
import TabletopKit
internal import Spatial

struct PlayerSeat: TableSeat {
    typealias State = TableSeatState

    let id: TableSeatIdentifier
    let initialState: State

    init(
        index: Int,
        position: TableVisualState.Point2D,
        rotation: Angle2D
    ) {
        id = .init(index)
        initialState = .init(
            pose: .init(
                position: position,
                rotation: rotation
            )
        )
    }
}
