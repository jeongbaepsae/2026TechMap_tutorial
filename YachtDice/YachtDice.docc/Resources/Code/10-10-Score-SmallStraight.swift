let values = Set(dice)
let patterns: [Set<Int>] = [
    [1, 2, 3, 4],
    [2, 3, 4, 5],
    [3, 4, 5, 6]
]

return patterns.contains { $0.isSubset(of: values) } ? 15 : 0
