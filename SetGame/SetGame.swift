//
//  SetGame.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import Foundation

struct SetCardGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("Card chosen: \(card)")
    }
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}
