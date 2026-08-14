interaction.toss(
    equipmentID: controlledDie.id,
    as: controlledDie.tossableRepresentation
)

for die in extraDiceToToss {
    interaction.toss(
        equipmentID: die.id,
        as: die.tossableRepresentation
    )
}
