for (index, die) in extraDiceToToss.enumerated() {
    interaction.addAction(
        .moveEquipment(
            die,
            childOf: controlledDie,
            pose: groupedDicePoses[index]
        )
    )
}
