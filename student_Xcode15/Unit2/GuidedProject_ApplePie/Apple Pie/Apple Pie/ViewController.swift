//
//  ViewController.swift
//  Apple Pie
//
//  Created by remotestudent on 12/1/24.
//

import UIKit

class ViewController: UIViewController {
    var listOfWords = ["buccaneer", "swift", "glorious", "incandescent", "bug", "program"]
    let incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    var pastGameWord: String = "" // hold the current game word
    //var pastGameWord: Game!

    @IBOutlet var treeImageView: UIImageView!
    @IBOutlet var correctWordLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newRound()
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
            showRoundOver() // call the method to show the correct word
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
            showRoundOver() // call the method to show the correct word
        } else {
            updateUI()
        }
    }
    
    func showRoundOver() {
        messageLabel.text = "Round Over! The correct word was: \(pastGameWord)"
        enableLetterButtons(false) // disable letter buttons to prevent further guesses
    }
    
    func newRound() {
        if !listOfWords.isEmpty {
            pastGameWord = currentGame?.word ?? ""// save the current word
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
            messageLabel.text = "" //clear the message for new round
        } else {
            enableLetterButtons(false)
        }
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

