//
//  UsableItem.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/30.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct UsableItem: Item {
    static let potionOfHealing = 400
    static let antidote = 401
    
    var id: Int
    var name: String
    var description: String
    var price: Int
    
    init(id: Int) {
        self.id = id
        
        switch id {
        case Self.potionOfHealing:
            name = "potion of healing"
            description = "recover 2d4 + 2 HP"
            price = 5000
        case Self.antidote:
            name = "antidote"
            description = "recover from poisoned status"
            price = 5000
        default:
            name = "dummy"
            description = ""
            price = 0
        }
    }
    
    var useAction: Action {
        switch id {
        case Self.potionOfHealing:
            return .drinkPotionOfHealing
        case Self.antidote:
            return .drinkAntidote
        default:
            return .noAction
        }
    }
}
