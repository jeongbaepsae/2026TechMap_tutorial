func cubeDie(index: Int, height: Float = 0.02) -> Die {
    Die(
        index: index,
        entityName: "dice/D6",
        representation: .cube(height: height),
        faceMap: cubeFaceMap
    )
}
