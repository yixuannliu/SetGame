//
//  ContentView.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var viewModel: SetGameViewModel
    var body: some View {
        VStack {
            Grid(viewModel.cards) { card in
                    CardView(card: card).onTapGesture{
                        withAnimation(.linear(duration: 0.75)) {
                            self.viewModel.choose(card: card)
                        }
                    }
            .padding(5)
            }
            .padding(.bottom).padding(.leading).padding(.trailing)
            .foregroundColor(Color.green)
        }
    }
}

struct CardView: View{
    var card: SetGame<String>.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            self.body(for: geometry.size)
        })
    }
    
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth )
            Text(card.content).font(Font.system(size: fontSize(for: size)))
        }
    }
    
    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3
    
    private func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.7
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SetGameViewModel()
        game.choose(card: game.cards[2])
        return SetGameView(viewModel: game)
    }
}
