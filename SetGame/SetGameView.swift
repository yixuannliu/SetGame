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
                    self.viewModel.select(card: card)
                }
                .padding(5)
            }
            .padding(.all, 10)
            .foregroundColor(Color.gray)
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
            if card.isSelected {
                 RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.blue, lineWidth: edgeLineWidth )
                    .shadow(color: Color.blue, radius: 3)
            } else {
                RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.gray, lineWidth: edgeLineWidth )
            }
//            Text(card.content).font(Font.system(size: fontSize(for: size)))
            HStack {
                ForEach(0..<card.content.number) { _ in
                    self.featuredCardContent
                    .frame(width: 30, height: 60)
                    .padding(2)
                }
            }
        }
        
    }
    
    private var featuredCardContent: some View {
        var color: Color
        switch card.content.color {
            case .green: color = Color.green
            case .purple: color = Color.purple
            case .red: color = Color.red
        }
        
        var shading: Double
        switch card.content.shading {
            case .solid : shading = 1
            case .semiTransparent: shading = 0.3
            case .transparent: shading = 0
        }
        
        switch card.content.shape {
            case .rectangle: return AnyView(ZStack {
                Rectangle().fill(color).opacity(shading)
                Rectangle().stroke(color, lineWidth: 3)
            })
            case .oval: return AnyView(ZStack {
                Capsule().fill(color).opacity(shading)
                Capsule().stroke(color, lineWidth: 3)
            })
            case .diamond: return AnyView(ZStack {
                Diamond().fill(color).opacity(shading)
                Diamond().stroke(color, lineWidth: 3)
            })
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

//extension Color {
//    static let neuBackground = Color(hex: "f0f0f3")
//    static let dropShadow = Color(hex: "aeaec0").opacity(0.4)
//    static let dropLight = Color(hex: "ffffff")
//}
//
//extension Color {
//    init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
//        var rgbValue: UInt64 = 0
//        scanner.scanHexInt64(&rgbValue)
//
//        let r = (rgbValue & 0xff0000) >> 16
//        let g = (rgbValue & 0xff00) >> 8
//        let b = rgbValue & 0xff
//
//        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
//    }
//}
