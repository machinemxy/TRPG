//
//  Skill.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct Skill {
    static let persuasion = 0
    static let dummy = 999
    
    var name: String
    var description: String
    
    init(id: Int) {
        switch id {
        case 0:
            name = "Persuasion"
            description = "Persuade someone to change his mind. Your charisma will affect the success rate."
        default:
            name = "dummy"
            description = "dummy"
        }
    }
}
