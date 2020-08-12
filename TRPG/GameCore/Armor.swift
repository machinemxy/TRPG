//
//  Armor.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Armor: Item {
    static let none = 200
    static let letherArmor = 201
    
    var id: Int
    var name: String
    var ac: Int
    var standard: Int
    var requiredStr: Int
    
    init(id: Int) {
        self.id = id
        
        switch id {
        case Self.letherArmor:
            name = "lether armor"
            ac = 11
            standard = 0
            requiredStr = 0
        default:
            // none
            name = "none"
            ac = 10
            standard = 0
            requiredStr = 0
        }
    }
}
