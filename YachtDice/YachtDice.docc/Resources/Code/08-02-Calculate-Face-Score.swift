guard let score = faceMap.value(for: currentFace) else {
    fatalError("The wrong face map was used")
}

return score
