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
    
    var name: String
    var description: String
    
    init(id: Int) {
        switch id {
        case UselessItem.grassShoes:
            name = "grass shoes"
            description = "made by Liu Bei"
        case UselessItem.yellowTurban:
            name = "yellow turban"
            description = "the symbol of Yellow Turban Army"
        default:
            name = "dummy"
            description = ""
        }
    }
}
