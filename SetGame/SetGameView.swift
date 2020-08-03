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
                        self.viewModel.choose(card: card)
                    }
            .padding(5)
            }
            .padding(.bottom).padding(.leading).padding(.trailing)
            .foregroundColor(Color.green)
        }
    }
}

struct CardView: View{
    var card: SetCardGame<FeaturedCardContent>.Card
    
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
//            Text(card.content).font(Font.system(size: fontSize(for: size)))
            drawFeaturedCardContent(cardContent: card.content)
        }
    }
    
    private func drawFeaturedCardContent(cardContent: FeaturedCardContent) -> some View {
        var color: Color
        switch cardContent.color {
            case .green: color = Color.green
            case .purple: color = Color.purple
            case .red: color = Color.red
        }
        
        switch cardContent.shape {
            case .rectangle: return AnyView(ZStack {
                Rectangle().fill(cardContent.shading == ShadingType.transparent ? Color.white : color)
                Rectangle().stroke(color, lineWidth: 3)
            }).opacity(cardContent.shading == ShadingType.semiTransparent ? 0.5 : 1).frame(width: 50, height: 50)
            case .oval: return AnyView(ZStack {
                Capsule().fill(cardContent.shading == ShadingType.transparent ? Color.white : color)
                Capsule().stroke(color, lineWidth: 3)
            }).opacity(cardContent.shading == ShadingType.semiTransparent ? 0.5 : 1).frame(width: 50, height: 75)
            case .diamond: return AnyView(ZStack {
                Circle().fill(cardContent.shading == ShadingType.transparent ? Color.white : color)
                Circle().stroke(color, lineWidth: 3)
            }).opacity(cardContent.shading == ShadingType.semiTransparent ? 0.5 : 1).frame(width: 50, height: 50)
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
        SetGameView(viewModel: SetGameViewModel())
    }
}
