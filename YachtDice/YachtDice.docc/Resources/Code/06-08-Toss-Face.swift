func onTossStart(
    interaction: TabletopInteraction,
    outcomes: [TabletopInteraction.TossOutcome]
) {
    guard let outcome = outcomes.first else { return }

    let face = outcome.tossableRepresentation.face(
        for: outcome.restingOrientation
    )
}
