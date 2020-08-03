//
//  Diamond.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-03.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {    
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: 0))
        p.addLine(to: CGPoint(x: 0, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.height))
        p.addLine(to: CGPoint(x: rect.width, y: rect.midY))
        p.closeSubpath()
        return p
    }
}
