//
//  SetGame.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import Foundation

struct SetCardGame {
    private(set) var cards: Array<Card>
    private var deck = CardDeck()
    
    mutating func select(card: Card) {
        if let selectedIndex: Int = cards.firstIndex(matching: card) {
            // check if three cards matching
            let selectedCards = cards.filter{ $0.isSelected }
            if selectedCards.count == 3 {
                if Card.checkMatching(selectedCards: selectedCards) {
                    for card in selectedCards {
                        if let matchedCardIndex: Int = cards.firstIndex(matching: card) {
                            // replace three more cards from deck
                            self.cards.remove(at: matchedCardIndex)
                            if let newCard = deck.drawOneCard() {
                                cards.insert(newCard, at: matchedCardIndex)
                            }
                        }
                    }
                } else {
                    // unselect all three cards
                    for index in 0..<cards.count {
                        self.cards[index].isSelected = false
                    }
                }
            }
            self.cards[selectedIndex].isSelected.toggle()
        }
    }
    
    
    init(){
        cards = deck.drawMultipleCards(numbersOfCards: 12)
    }
    
    struct Card: Identifiable {
        var isSelected: Bool = false
//        var isMatched: Bool = false
        var content: FeaturedCardContent
        var id: Int
        
        init(color: ColorType, shape: ShapeType, number: Int, shading: ShadingType, index: Int) {
            content = FeaturedCardContent(color: color, shape: shape, number: number, shading: shading)
            id = index
        }
        
        static func checkMatching(selectedCards: Array<Card>) -> Bool {
            var featureCount: [String: Int] = [:]
            for card in selectedCards {
                let content = card.content
                featureCount[content.color.rawValue, default: 0] += 1
                featureCount[content.shape.rawValue, default: 0] += 1
                featureCount[content.shading.rawValue, default: 0] += 1
                featureCount[String(content.number), default: 0] += 1
            }
            print("featureCount: \(featureCount)")
            let featureWithTwoInCommon = featureCount.filter{ $0.value == 2 }
            print(featureWithTwoInCommon)
            return featureWithTwoInCommon.count == 0
        }
        
        struct FeaturedCardContent: Equatable {
            var color: ColorType
            var shape: ShapeType
            var number: Int
            var shading: ShadingType
            
            static func ==(lhs: FeaturedCardContent, rhs: FeaturedCardContent) -> Bool {
                return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.shading == rhs.shading && lhs.number == rhs.number
            }
        }
    }
    
    struct CardDeck {
        var cards: Array<Card>
        
        mutating func drawOneCard() -> Card? {
            if cards.count > 0 {
                return self.cards.removeFirst()
            }
            return nil
        }
        
        mutating func drawMultipleCards(numbersOfCards: Int) -> Array<Card> {
            if cards.count >= numbersOfCards {
                let drawedCards: Array<Card> = Array(cards[0..<numbersOfCards])
                self.cards.removeFirst(numbersOfCards)
                return drawedCards
            }
            return []
        }
        
        init() {
            cards = []
            var count: Int = 0
            for number in NumbersOfSymbol.allCases {
                for color in ColorType.allCases {
                    for shape in ShapeType.allCases {
                        for shading in ShadingType.allCases {
                            cards.append(Card(color: color, shape: shape, number: number.rawValue, shading: shading, index: count))
                            count += 1
                        }
                    }
                }
            }
            cards.shuffle()
        }
    }
}
