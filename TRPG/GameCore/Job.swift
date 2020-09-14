//
//  Job.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/14.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum Job: String, Codable {
    case paladin = "Paladin"
    case fighter = "Fighter"
    case barbarian = "Barbarian"
    case no = "No"
    
    var lifeDice: Int {
        switch self {
        case .paladin:
            return 10
        case .fighter:
            return 10
        case .barbarian:
            return 12
        case .no:
            return 4
        }
    }
    
    var goodAtAbilities: [BasicAbility] {
        switch self {
        case .paladin:
            return [.wis, .cha]
        case .fighter:
            return [.str, .con]
        case .barbarian:
            return [.str, .con]
        case .no:
            return []
        }
    }
}
