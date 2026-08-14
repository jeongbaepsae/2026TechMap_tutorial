if scoreSheet.isComplete {
    Label("Game Complete", systemImage: "flag.checkered")
    Text("Final Score: \(scoreSheet.totalScore)")

    Button("Start New Game") {
        onStartNewGame()
    }
}
