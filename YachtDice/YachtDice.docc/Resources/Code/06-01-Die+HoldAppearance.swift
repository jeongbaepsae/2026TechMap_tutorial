import UIKit
import RealityKit

extension Die {
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
                guard var pbr = material as? PhysicallyBasedMaterial else {
                    return material
                }

                let texture = pbr.baseColor.texture
                pbr.baseColor = .init(tint: tint, texture: texture)
                return pbr
            }
            entity.components.set(modelComponent)
        }

        for child in entity.children {
            updateMaterials(in: child, tint: tint)
        }
    }
}
