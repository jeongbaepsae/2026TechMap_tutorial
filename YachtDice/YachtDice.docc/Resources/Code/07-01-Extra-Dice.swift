var extraDiceToToss: [Die] = []

extraDiceToToss = game.dice.filter { die in
    die.id != controlledDie.id
}
