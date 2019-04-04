//
//  Memory.swift
//  Memory
//
//  Created by Maxim Vitovitsky on 29/03/2019.
//  Copyright © 2019 Максим Витовицкий. All rights reserved.
//

import Foundation

class Memory {
    
    var cards = [Card]()
    
    var indexOfFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if cards[index].isMatched {
            return
        }
        
        if let matchIndex = indexOfFaceUpCard, matchIndex != index {
            if cards[matchIndex].id == cards[index].id {
                cards[matchIndex].isMatched = true
                cards[index].isMatched = true
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = nil
        } else {
            for cardIndex in cards.indices {
                cards[cardIndex].isFaceUp = false
            }
            cards[index].isFaceUp = true
            indexOfFaceUpCard = index
        }
    }
    
    init(numberOfPairsOfCrads: Int) {
        for _ in 1...numberOfPairsOfCrads {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    var allCardsHaveBeenMatched: Bool {
        for index in cards.indices {
            if !cards[index].isMatched { return false }
        }
        return true
    }
    
}
