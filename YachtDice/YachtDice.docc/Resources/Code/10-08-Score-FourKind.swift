let counts = frequencyMap(for: dice)
guard counts.values.contains(where: { $0 >= 4 }) else {
    return 0
}
return dice.reduce(0, +)
