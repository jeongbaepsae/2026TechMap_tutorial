func setHeldAppearance(_ isHeld: Bool) {
    updateMaterials(
        in: entity,
        tint: isHeld ? .systemBlue : .white
    )
}
