if die.id != controlledDie.id {
    interaction.addAction(
        .moveEquipment(
            matching: die.id,
            childOf: .tableID
        )
    )
}
