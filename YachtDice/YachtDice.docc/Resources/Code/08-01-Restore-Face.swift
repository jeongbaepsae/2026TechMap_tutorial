guard let currentFace = faceType.init(
    rawValue: state.rawValue
) else {
    fatalError("Invalid die face raw value")
}
