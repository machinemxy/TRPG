//
//  Armor.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Armor: Item {
    static let padded = 200
    
    var name: String
    var description: String
    var ac: Int
    var standard: Int
    var requiredStr: Int
    var price: Int
    
    init(id: Int?) {
        switch id {
        case Self.padded:
            name = "padded armor"
            description = "armor class 11"
            ac = 11
            standard = 0
            requiredStr = 0
            price = 500
        default:
            // none
            name = "none"
            description = "armor class 10"
            ac = 10
            standard = 0
            requiredStr = 0
            price = 0
        }
    }
}
