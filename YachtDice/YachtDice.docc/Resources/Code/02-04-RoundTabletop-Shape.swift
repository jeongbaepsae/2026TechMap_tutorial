init() {
    entity = try! Entity.load(named: "table/table", in: realityKitContentBundle)
    shape = .round(entity: entity)
}
