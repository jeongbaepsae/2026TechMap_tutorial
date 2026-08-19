private func numberScore(dice: [Int], targetFace: Int) -> Int {
    dice
        .filter { $0 == targetFace }
        .reduce(0, +)
}
