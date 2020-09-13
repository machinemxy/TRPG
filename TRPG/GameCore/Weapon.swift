//
//  Weapon.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/11.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Weapon: Item {
    static let club = 0
    static let greatClub = 1
    
    var name: String
    var description: String
    var damageA: Int
    var damageB: Int
    var needTwoHand: Bool
    var price: Int
    
    init(id: Int?) {
        switch id {
        case Self.club:
            name = "club"
            description = "damage 1D4"
            damageA = 1
            damageB = 4
            needTwoHand = false
            price = 10
        case Self.greatClub:
            name = "great club"
            description = "damage 1D8, two hands"
            damageA = 1
            damageB = 8
            needTwoHand = true
            price = 20
        default:
            // bare hand
            name = "bare hand"
            description = "damage 1D2"
            damageA = 1
            damageB = 2
            needTwoHand = false
            price = 0
        }
    }
}
