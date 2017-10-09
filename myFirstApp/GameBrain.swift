//
//  GameBrain.swift
//  myFirstApp
//
//  Created by C4Q  on 10/2/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import Foundation
import UIKit

enum GameStatus {
    case gameOver
    case correctGuess(Int)
    case incorrectGuess(Int)
}


class GameBrain {
    init() {
        self.currentCorrectColor = getRandomColor()
    }
    
    var currentCorrectColor: UIColor = UIColor.green

    func userGuessed(color: UIColor) -> GameStatus {
        let correctColor = self.currentCorrectColor
        self.currentCorrectColor = getRandomColor()
        if color == correctColor {
            currentScore += 1
            return GameStatus.correctGuess(currentScore)
        } else {
            incorrectGuesses += 1
            if incorrectGuesses == maxIncorrectGuesses {
                return GameStatus.gameOver
            }
        }
        return .incorrectGuess(incorrectGuesses)
    }
    
    private func getRandomColor() -> UIColor {
        var colors = self.colors
        colors.remove(at: colors.index(of: self.currentCorrectColor)!)
        return colors[Int(arc4random_uniform(1))]
    }
    private var incorrectGuesses = 0
    private var maxIncorrectGuesses = 3
    private var currentScore = 0
    private var colors = [UIColor.red, UIColor.yellow, UIColor.green]
}
