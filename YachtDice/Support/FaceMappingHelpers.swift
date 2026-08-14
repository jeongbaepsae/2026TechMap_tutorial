/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A definition of every equipment type that the app uses.
*/

import TabletopKit

// A helper structure that represents a 1-1 mapping between faces of a specific
// type to score, like TetrahedronFace.
//
// The correspondence between logical faces and scores is arbitrary and depends
// on the game.
//
// Different dice with the same geometric shape could have different mappings
// because they can have different values on their faces. For example, see
// `octahedronFaceMap` and `customOctahedronFaceMap` below.
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

// A protocol that helps store mappings regardless of the actual face type.
protocol TossableFaceMap {
    func value(for face: any TossableRepresentation.TossableFace) -> Int?
}

// MARK: - Dice Mappings

// The dice mappings that the game uses.
//
// The assets in the sample are made to match the order of the faces in the enum,
// using standard die face positioning, so the mapping is trivial. However,
// `D8_customFaces` has some more arbitrary face values.
//
// Other games might have more interesting mappings, for example:
// - different order of the faces
// - non-standard faces (D4 with faces 10, 20, 42, 1000, or "dragon face", "firework face" etc)

let cubeFaceMap: FaceMap<TossableRepresentation.CubeFace> = [
    .a: 1,
    .b: 2,
    .c: 3,
    .d: 4,
    .e: 5,
    .f: 6
]
