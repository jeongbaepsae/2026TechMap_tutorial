import UIKit
import RealityKit
import TabletopKit
import RealityKitContent
internal import Spatial

extension EquipmentIdentifier {
    static func diceID(_ index: Int) -> Self {
        .init(1000 + index)
    }
}

final class Die: EntityEquipment {
    let entity: Entity
    let id: EquipmentIdentifier
    let initialState: RawValueState

    let tossableRepresentation: TossableRepresentation
    let faceType: any TossableRepresentation.TossableFace.Type
    let faceMap: any TossableFaceMap

    init(index: Int) {
        let representation = TossableRepresentation.cube(height: 0.02)
        let initialFace = representation.face(for: .identity)

        let spacing: Double = 0.06
        let startX: Double = -0.15
        let initialPose = TableVisualState.Pose2D(
            position: .init(
                x: startX + Double(index) * spacing,
                z: 0
            ),
            rotation: .zero
        )

        entity = try! ModelEntity.load(
            named: "dice/D6",
            in: realityKitContentBundle
        )
        id = .diceID(index)
        initialState = .init(
            rawValue: initialFace.rawValue,
            parentID: .tableID,
            pose: initialPose,
            entity: entity
        )
        tossableRepresentation = representation
        faceType = type(of: initialFace)
        faceMap = cubeFaceMap
    }

    func calculateScore(for state: RawValueState) -> Int {
        guard let currentFace = faceType.init(rawValue: state.rawValue),
              let score = faceMap.value(for: currentFace) else {
            fatalError("Unable to read the die face")
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
