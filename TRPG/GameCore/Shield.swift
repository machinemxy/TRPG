//
//  Shield.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Shield: Item {
    static let none = 100
    static let shield = 101
    
    var id: Int
    var name: String
    var ac: Int
    
    init(id: Int) {
        self.id = id
        
        switch id {
        case Self.shield:
            name = "shield"
            ac = 2
        default:
            // none
            name = "none"
            ac = 0
        }
    }
}
