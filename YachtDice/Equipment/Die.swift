/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
An object that represents a die and functions for different dice types.
*/
import UIKit
import RealityKit
import TabletopKit
import RealityKitContent
internal import Spatial

extension EquipmentIdentifier {
    static var tableID: Self { .init(0) }
    static func diceID(_ index: Int) -> Self { .init(1000 + index) }
}

final class Die: EntityEquipment {
    let entity: Entity
    let id: EquipmentIdentifier
    let initialState: RawValueState

    let tossableRepresentation: TossableRepresentation
    let faceType: any TossableRepresentation.TossableFace.Type
    let faceMap: any TossableFaceMap

    init(
        index: Int,
        entityName: String,
        representation: TossableRepresentation,
        faceMap: any TossableFaceMap
    ) {
        let spacing: Double = 0.06
        let startX: Double = -0.15
        let initialPose = TableVisualState.Pose2D(
            position: .init(
                x: startX + Double(index) * spacing,
                z: 0
            ),
            rotation: .zero
        )
        let initialFace = representation.face(for: .identity)

        entity = try! ModelEntity.load(
            named: entityName,
            in: realityKitContentBundle
        )
        addShadowRecursive(entity: entity)

        id = .diceID(index)
        initialState = .init(
            rawValue: initialFace.rawValue,
            parentID: .tableID,
            pose: initialPose,
            entity: entity
        )
        tossableRepresentation = representation
        faceType = type(of: initialFace)
        self.faceMap = faceMap
    }

    func restingOrientation(state: RawValueState) -> Rotation3D {
        guard let currentFace = faceType.init(rawValue: state.rawValue) else {
            fatalError("The rawValue in the state was set with an invalid value.")
        }

        return currentFace.restingOrientation
    }

    func calculateScore(for state: RawValueState) -> Int {
        guard let currentFace = faceType.init(rawValue: state.rawValue) else {
            fatalError("The rawValue in the state was set with an invalid value")
        }

        guard let score = faceMap.value(for: currentFace) else {
            fatalError("The wrong face map was used when initializing this die")
        }

        return score
    }

    func setHeldAppearance(_ isHeld: Bool) {
        updateMaterials(
            in: entity,
            tint: isHeld ? .systemBlue : .white
        )
    }

    private func updateMaterials(
        in entity: Entity,
        tint: UIColor
    ) {
        if var modelComponent = entity.components[ModelComponent.self] {
            modelComponent.materials = modelComponent.materials.map { material in
                guard var pbrMaterial = material as? PhysicallyBasedMaterial else {
                    return material
                }

                let texture = pbrMaterial.baseColor.texture
                pbrMaterial.baseColor = PhysicallyBasedMaterial.BaseColor(
                    tint: tint,
                    texture: texture
                )

                return pbrMaterial
            }

            entity.components.set(modelComponent)
        }

        for child in entity.children {
            updateMaterials(in: child, tint: tint)
        }
    }
}

func cubeDie(index: Int, height: Float = 0.02) -> Die {
    Die(
        index: index,
        entityName: "dice/D6",
        representation: TossableRepresentation.cube(height: height),
        faceMap: cubeFaceMap
    )
}
