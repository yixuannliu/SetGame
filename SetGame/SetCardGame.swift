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
    private var selectedCards: Array<Card>
    private var deck: Array<FeaturedCardContent>
    
    mutating func select(card: Card) {
        if let selectedIndex: Int = cards.firstIndex(matching: card), !cards[selectedIndex].isMatched {
            self.cards[selectedIndex].isSelected = !card.isSelected
            if self.cards[selectedIndex].isSelected && selectedCards.count < 3 {
                selectedCards.append(card)
            }
            if selectedCards.count == 3 {
                print(FeaturedCardContent.checkMatching(selectedCards: selectedCards))
            }
        }
    }
    
    init(){
        cards = Array<Card>()
        deck = CardDeck().cards
        for pairIndex in 0..<12 {
            let content = deck[pairIndex]
            cards.append(Card(content: content, id: pairIndex))
        }
        cards.shuffle()
        selectedCards = []
    }
    
    struct Card: Identifiable {
        var isSelected: Bool = false
        var isMatched: Bool = false
        var content: FeaturedCardContent
        var id: Int
    }

    struct FeaturedCardContent: Equatable {
        var color: ColorType
        var shape: ShapeType
        var number: Int
        var shading: ShadingType
        
        static func ==(lhs: FeaturedCardContent, rhs: FeaturedCardContent) -> Bool {
            return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.shading == rhs.shading && lhs.number == rhs.number
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
            return false
        }
    }
    
    struct CardDeck {
        var cards: Array<FeaturedCardContent>
        
        init() {
            cards = []
            for number in NumbersOfSymbol.allCases {
                for color in ColorType.allCases {
                    for shape in ShapeType.allCases {
                        for shading in ShadingType.allCases {
                            cards.append(FeaturedCardContent(color: color, shape: shape, number: number.rawValue, shading: shading))
                        }
                    }
                }
            }
            cards.shuffle()
        }
    }
}
