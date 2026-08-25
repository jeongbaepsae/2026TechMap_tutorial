import TabletopKit

struct PlayerSeat: TableSeat {
    let id: TableSeatIdentifier
    let initialState: TableSeatState

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
