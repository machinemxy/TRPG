//
//  UselessItem.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/27.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct UselessItem: Item {
    static let grassShoes = 300
    static let yellowTurban = 301
    static let snakeSkin = 302
    
    var name: String
    var description: String
    
    init(id: Int) {
        switch id {
        case Self.grassShoes:
            name = "grass shoes"
            description = "made by Liu Bei"
        case Self.yellowTurban:
            name = "yellow turban"
            description = "the symbol of Yellow Turban Army"
        case Self.snakeSkin:
            name = "snake skin"
            description = "the skin of snake"
        default:
            name = "dummy"
            description = ""
        }
    }
}
