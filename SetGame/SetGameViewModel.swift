//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var gameModel: SetGame<String> = createSetGame()
    
    private static func createSetGame() -> SetGame<String> {
        let cardContent = ["A", "B", "C", "D", "1", "2", "3", "4", "a", "b", "c", "d"]
        return SetGame<String>(numberOfPairsOfCards: 12)
        {pairIndex in
            return cardContent[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<SetGame<String>.Card> {
        gameModel.cards
    }
    
    // MARK: - Intents(s)
    func choose(card: SetGame<String>.Card) {
        gameModel.choose(card: card)
    }
    
//    func restartMemoryGame() {
//        gameModel = EmojiMemoryGame.createMemoryGame()
//    }
}

