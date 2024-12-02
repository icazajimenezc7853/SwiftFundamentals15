import UIKit

class ViewController: UIViewController {
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0
    var totalLosses = 0
    var currentGame: Game!
    var pastGameWord: String = "" // hold the current game word

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound() // Start the first round
    }
        
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.titleLabel?.text
        let letter = Character(letterString!.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
            showRoundOver() // Show the round over message
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            showRoundOver() // Show the round over message
        } else {
            updateUI()
        }
    }
    
    func showRoundOver() {
        let alert = UIAlertController(title: "Round Over", message: nil, preferredStyle: .alert)
    
        // Create the message with the word bolded
        let message = "The correct word was: "
        let boldWord = currentGame.word
        let attributedMessage = NSMutableAttributedString(string: message, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18) // Regular font size
        ])
    
        // Append the bold word
        let boldAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 18) // Bold font size
        ]
        attributedMessage.append(NSAttributedString(string: boldWord, attributes: boldAttributes))
    
        // Set the attributed message to the alert
        alert.setValue(attributedMessage, forKey: "attributedMessage")
    
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.newRound() // Start the next round when the alert is dismissed
        }))
    
        present(alert, animated: true, completion: nil)
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            pastGameWord = currentGame?.word ?? "" // Save the current word
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            // Game is finished, show final results
            showFinalResults()
        }
    }
    
    func showFinalResults() {
        let alert = UIAlertController(title: "Game Over", message: "Total Wins: \(totalWins), Total Losses: \(totalLosses)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.resetGame() // Reset the game if desired
        }))
        present(alert, animated: true, completion: nil)
    }
    
    func resetGame() {
        totalWins = 0
        totalLosses = 0
        listOfWords.shuffle() // Shuffle words for a new game
        newRound() // Start a new game
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
}
