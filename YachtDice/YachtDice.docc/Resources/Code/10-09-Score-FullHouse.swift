let sortedCounts = frequencyMap(for: dice).values.sorted()
guard sortedCounts == [2, 3] else { return 0 }
return dice.reduce(0, +)
