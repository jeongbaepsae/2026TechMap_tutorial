let values = Set(dice)
let isStraight =
    values == Set([1, 2, 3, 4, 5]) ||
    values == Set([2, 3, 4, 5, 6])

return isStraight ? 30 : 0
