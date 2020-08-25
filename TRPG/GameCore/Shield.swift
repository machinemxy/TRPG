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
    var ac: Int
    
    init(id: Int?) {
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
