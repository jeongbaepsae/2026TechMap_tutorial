init() {
    entity = try! Entity.load(
        named: "table/table",
        in: realityKitContentBundle
    )
}
