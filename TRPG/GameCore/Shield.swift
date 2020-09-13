//
//  Shield.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Shield: Item {
    static let shield = 100
    
    var name: String
    var description: String
    var ac: Int
    var price: Int
    
    init(id: Int?) {
        switch id {
        case Self.shield:
            name = "shield"
            description = "armor class + 2"
            ac = 2
            price = 1000
        default:
            // none
            name = "none"
            description = ""
            ac = 0
            price = 0
        }
    }
}
