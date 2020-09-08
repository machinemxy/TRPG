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
    
    var id: Int
    var name: String
    var description: String
    
    init(id: Int) {
        self.id = id
        
        switch id {
        case Self.potionOfHealing:
            name = "potion of healing"
            description = "recover 2d4 + 2 HP"
        default:
            name = "dummy"
            description = ""
        }
    }
    
    var useAction: Action {
        switch id {
        case 400:
            return .drinkPotionOfHealing
        default:
            return .noAction
        }
    }
}
