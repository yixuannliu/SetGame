//
//  Types.swift
//  SetGame
//
//  Created by Cosmos Liu on 2020-08-02.
//  Copyright © 2020 Cosmos Liu. All rights reserved.
//

import SwiftUI

enum NumbersOfSymbol: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum ColorType: String, CaseIterable {
    case green
    case purple
    case red
}

enum ShapeType: String, CaseIterable {
    case rectangle
    case diamond
    case oval
}

enum ShadingType: String, CaseIterable {
    case solid
    case semiTransparent
    case transparent
}
