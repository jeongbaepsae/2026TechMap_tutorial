private func isValid(_ dice: [Int]) -> Bool {
    dice.count == 5 &&
    dice.allSatisfy { 1...6 ~= $0 }
}
