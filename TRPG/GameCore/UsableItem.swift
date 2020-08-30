//
//  UsableItem.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/30.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum UsableItemType {
    case recovery
}

struct UsableItem: Item {
    static let potionOfHealing = 400
    
    var name: String
    var description: String
    var type: UsableItemType
    var effectA: Int
    var effectB: Int
    var effectC: Int
    
    init(id: Int) {
        switch id {
        case UsableItem.potionOfHealing:
            name = "potion of healing"
            description = "recover 2d4 + 2 HP"
            type = .recovery
            effectA = 2
            effectB = 4
            effectC = 2
        default:
            name = "dummy"
            description = ""
            type = .recovery
            effectA = 1
            effectB = 0
            effectC = 0
        }
    }
}
