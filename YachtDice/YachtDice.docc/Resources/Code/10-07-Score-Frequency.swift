private func frequencyMap(for dice: [Int]) -> [Int: Int] {
    dice.reduce(into: [:]) { result, value in
        result[value, default: 0] += 1
    }
}
