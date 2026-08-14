let initialFace = representation.face(for: .identity)

id = .diceID(index)
initialState = .init(
    rawValue: initialFace.rawValue,
    parentID: .tableID,
    pose: initialPose,
    entity: entity
)
