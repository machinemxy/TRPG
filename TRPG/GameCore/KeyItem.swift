//
//  KeyItem.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/27.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct KeyItem: Item {
    static let grassShoes = 300
    
    var name: String
    var description: String
    
    init(id: Int) {
        switch id {
        case KeyItem.grassShoes:
            name = "grass shoes"
            description = "made by Liu Bei"
        default:
            name = "dummy"
            description = ""
        }
    }
}
