//
//  ViewController.swift
//  Memory
//
//  Created by Maxim Vitovitsky on 29/03/2019.
//  Copyright © 2019 Максим Витовицкий. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Memory(numberOfPairsOfCrads: (cardButtons.count + 1) / 2)
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func cardButtonAction(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateButtons()
        } else {
            print("This button is not in card buttons!")
        }
    }
    
    func updateButtons() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if button.backgroundColor != #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) {  // Don't show already matched cards
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor =  #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                
            }
            
            if card.isFaceUp {
                if card.isMatched {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        button.setTitle("", for: .normal)
                        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                    }
                }
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 0.2723996043, green: 0.6819463372, blue: 0.632582128, alpha: 1)
            }
            
            if game.allCardsHaveBeenMatched {
                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                    for _ in self.cardButtons.indices {
                        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                        button.setTitle("", for: .normal)
                    }
                }
            }
            endOfGame()
        }
    }
    
    var emojiList = ["🦊", "🐻", "🐼", "🐨", "🦁", "🐯", "🐵", "🦉", "🦇", "🦄", "🐸", "🐡", "🐊", "🐥"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojiList.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiList.count)
            emoji[card.id] = emojiList.remove(at: randomIndex)
        }
        
        return emoji[card.id] ?? "?"
    }
    
    func restartButtonPressed() {
        game = Memory(numberOfPairsOfCrads: (cardButtons.count + 1) / 2)
        updateButtons()
    } 
    
    func endOfGame() {
        if game.allCardsHaveBeenMatched {
            DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
                let alert = UIAlertController(title: "Awesome", message: "Do you want to restart?", preferredStyle: .alert)
                
                let restartAction = UIAlertAction(title: "Restart", style: .default) { (UIAlertaction) in
                    
                    self.restartButtonPressed()
                    
                }
                
                alert.addAction(restartAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}

