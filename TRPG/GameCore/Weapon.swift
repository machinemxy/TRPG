//
//  Weapon.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/11.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Weapon: Item {
    static let bareHand = 0
    static let club = 1
    
    var id: Int
    var name: String
    var minDamage: Int
    var maxDamage: Int
    var needTwoHand: Bool
    var isSimple: Bool
    
    init(id: Int) {
        self.id = id
        
        switch id {
        case Self.club:
            name = "club"
            minDamage = 1
            maxDamage = 4
            needTwoHand = false
            isSimple = true
        default:
            // bare hand
            name = "bare hand"
            minDamage = 1
            maxDamage = 2
            needTwoHand = false
            isSimple = true
        }
    }
}
