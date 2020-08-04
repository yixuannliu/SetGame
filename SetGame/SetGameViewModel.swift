//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var gameModel: SetCardGame = createSetGame()
    
    private static func createSetGame() -> SetCardGame {
        return SetCardGame()
    }
    
    func restartSetGame() {
        gameModel = SetGameViewModel.createSetGame()
    }
    
    // MARK: - Access to the Model
    var cards: Array<SetCardGame.Card> {
        gameModel.cards
    }
    
    // MARK: - Intents(s)
    func select(card: SetCardGame.Card) {
        gameModel.select(card: card)
    }
}


