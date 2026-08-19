func repositionTable(content: RealityViewContent, proxy: GeometryProxy3D) {
    let frame = content.convert(
        proxy.frame(in: .global),
        from: .global,
        to: .scene
    )
}
