//
//  SetGameViewModel.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import SwiftUI

class SetGameViewModel: ObservableObject {
    @Published private var gameModel: SetCardGame<FeaturedCardContent> = createSetGame()
    
    private static func createSetGame() -> SetCardGame<FeaturedCardContent> {
        let cardContent = [
            FeaturedCardContent(color: ColorType.green, shape: ShapeType.rectangle, number: 1, shading: ShadingType.solid),
            FeaturedCardContent(color: ColorType.purple, shape: ShapeType.diamond, number: 2, shading: ShadingType.transparent),
            FeaturedCardContent(color: ColorType.red, shape: ShapeType.oval, number: 3, shading: ShadingType.semiTransparent),
            FeaturedCardContent(color: ColorType.green, shape: ShapeType.rectangle, number: 2, shading: ShadingType.solid),
            FeaturedCardContent(color: ColorType.purple, shape: ShapeType.diamond, number: 3, shading: ShadingType.transparent),
            FeaturedCardContent(color: ColorType.red, shape: ShapeType.oval, number: 1, shading: ShadingType.semiTransparent),
            FeaturedCardContent(color: ColorType.green, shape: ShapeType.oval, number: 1, shading: ShadingType.solid),
            FeaturedCardContent(color: ColorType.purple, shape: ShapeType.oval, number: 2, shading: ShadingType.transparent),
            FeaturedCardContent(color: ColorType.red, shape: ShapeType.diamond, number: 3, shading: ShadingType.semiTransparent),
            FeaturedCardContent(color: ColorType.green, shape: ShapeType.diamond, number: 2, shading: ShadingType.solid),
            FeaturedCardContent(color: ColorType.purple, shape: ShapeType.rectangle, number: 3, shading: ShadingType.transparent),
            FeaturedCardContent(color: ColorType.red, shape: ShapeType.rectangle, number: 1, shading: ShadingType.semiTransparent)
        ]
        return SetCardGame<FeaturedCardContent>(numberOfPairsOfCards: 12)
        {pairIndex in
            return cardContent[pairIndex]
        }
    }
    
    // MARK: - Access to the Model
    var cards: Array<SetCardGame<FeaturedCardContent>.Card> {
        gameModel.cards
    }
    
    // MARK: - Intents(s)
    func select(card: SetCardGame<FeaturedCardContent>.Card) {
        gameModel.select(card: card)
    }
    
//    func restartMemoryGame() {
//        gameModel = EmojiMemoryGame.createMemoryGame()
//    }
}

struct FeaturedCardContent: Equatable {
    var color: ColorType
    var shape: ShapeType
    var number: Int
    var shading: ShadingType
}

extension FeaturedCardContent {
    static func ==(lhs: FeaturedCardContent, rhs: FeaturedCardContent) -> Bool {
        return lhs.color == rhs.color && lhs.shape == rhs.shape && lhs.shading == rhs.shading && lhs.number == rhs.number
    }
}
