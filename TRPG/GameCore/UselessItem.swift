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
    static let yellowWine = 303
    static let gardenKey = 304
    
    var name: String
    var description: String
    var price: Int
    
    init(id: Int) {
        switch id {
        case Self.grassShoes:
            name = "grass shoes"
            description = "made by Liu Bei"
            price = 10
        case Self.yellowTurban:
            name = "yellow turban"
            description = "the symbol of Yellow Turban Army"
            price = 2
        case Self.snakeSkin:
            name = "snake skin"
            description = "the skin of snake"
            price = 100
        case Self.yellowWine:
            name = "yellow wine"
            description = "most popular wine in the pub"
            price = 4
        case Self.gardenKey:
            name = "garden key"
            description = "key for the gate of peach garden"
            price = 1
        default:
            name = "dummy"
            description = ""
            price = 0
        }
    }
}
