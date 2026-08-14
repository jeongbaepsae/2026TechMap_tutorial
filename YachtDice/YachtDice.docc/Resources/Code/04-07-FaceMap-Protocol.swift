protocol TossableFaceMap {
    func value(
        for face: any TossableRepresentation.TossableFace
    ) -> Int?
}
