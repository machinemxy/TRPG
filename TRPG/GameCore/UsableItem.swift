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
    
    var name: String
    var description: String
    
    init(id: Int) {
        switch id {
        case UsableItem.potionOfHealing:
            name = "potion of healing"
            description = "recover 2d4 + 2 HP"
        default:
            name = "dummy"
            description = ""
        }
    }
}
