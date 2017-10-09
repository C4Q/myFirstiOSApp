//
//  ViewController.swift
//  myFirstApp
//
//  Created by C4Q  on 9/26/17.
//  Copyright © 2017 C4Q . All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var strikeOneLabel: UILabel!
    @IBOutlet weak var strikeTwoLabel: UILabel!
    @IBOutlet weak var strikeThreeLabel: UILabel!
    
    @IBOutlet weak var gameOverLabel: UILabel!
    
    @IBOutlet weak var currentPointsLabel: UILabel!
    
    @IBOutlet weak var colorView: UIView!
    
    var brain = GameBrain()
    
    @IBAction func newGame(_ sender: UIButton) {
        brain = GameBrain()
        [strikeOneLabel, strikeTwoLabel, strikeThreeLabel, gameOverLabel].forEach{$0.isHidden = true}
        currentPointsLabel.text = "0"
    }

    
    @IBAction func guessColor(_ sender: UIButton) {
        let selectedColor: UIColor
        switch sender.titleLabel!.text! {
        case "Yellow":
            selectedColor = .yellow
        case "Green":
            selectedColor = .green
        case "Red":
            selectedColor = .red
        default:
            print("Unknown color selected")
            selectedColor = .black
        }
        let result = brain.userGuessed(color: selectedColor)
        switch result {
        case .correctGuess(let correctGuessNum):
            updateScore(with: correctGuessNum)
            setNextColor()
        case .incorrectGuess(let incorrectGuessNum):
            updateIncorrectGuesses(with: incorrectGuessNum)
            setNextColor()
        case .gameOver:
            endGame()
        }
    }
    func updateScore(with newValue: Int) {
        currentPointsLabel.text = String(newValue)
    }
    
    func updateIncorrectGuesses(with newIncorrectGuesses: Int) {
        switch newIncorrectGuesses {
        case 1:
            strikeOneLabel.isHidden = false
        case 2:
            strikeTwoLabel.isHidden = false
        default:
            break
        }
    }
    
    func endGame() {
        strikeThreeLabel.isHidden = false
        gameOverLabel.isHidden = false
    }
    
    
    func setNextColor() {
        let newColor = brain.currentCorrectColor
        colorView.backgroundColor = newColor
    }
}

