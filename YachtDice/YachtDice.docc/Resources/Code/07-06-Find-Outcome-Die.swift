let allTossedDice = [controlledDie] + extraDiceToToss

for outcome in outcomes {
    guard let die = allTossedDice.first(
        where: { $0.id == outcome.id }
    ) else {
        continue
    }
}
