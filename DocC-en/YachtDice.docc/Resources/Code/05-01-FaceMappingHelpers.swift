/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A definition of every equipment type that the app uses.
*/

import TabletopKit

// Maps a TabletopKit toss face to the number used by this D6 asset.
struct FaceMap<FaceType: Hashable & TossableRepresentation.TossableFace>: TossableFaceMap, ExpressibleByDictionaryLiteral {
    private let faceToValue: [FaceType: Int]

    init(dictionaryLiteral elements: (FaceType, Int)...) {
        self.faceToValue = Dictionary(uniqueKeysWithValues: elements)
    }

    func value(for face: any TossableRepresentation.TossableFace) -> Int? {
        guard let face = face as? FaceType else {
            return nil
        }
        return faceToValue[face]
    }
}

protocol TossableFaceMap {
    func value(for face: any TossableRepresentation.TossableFace) -> Int?
}

// This mapping matches the orientation of the D6.usdz included with the tutorial.
let cubeFaceMap: FaceMap<TossableRepresentation.CubeFace> = [
    .a: 1,
    .b: 2,
    .c: 3,
    .d: 4,
    .e: 5,
    .f: 6
]
