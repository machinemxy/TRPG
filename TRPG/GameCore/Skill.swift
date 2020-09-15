//
//  Skill.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum SkillType: String, Codable {
    case persuasion
    case greatWeaponFighting
}

struct Skill: Codable {
    var name: String
    var description: String
    
    init(type: SkillType) {
        switch type {
        case .persuasion:
            name = "Persuasion"
            description = "Persuade someone to change his mind. Your charisma will affect the success rate."
        case .greatWeaponFighting:
            name = "Great Weapon Fighting"
            description = "When you use two-handed weapon and rolled 1 or 2 on any damage dice, you can reroll it and accept the new result."
        }
    }
}
