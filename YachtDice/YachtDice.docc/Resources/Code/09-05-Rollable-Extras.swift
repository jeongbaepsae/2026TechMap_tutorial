extraDiceToToss = game.rollableDice.filter { die in
    die.id != controlledDie.id
}
