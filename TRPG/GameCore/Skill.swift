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
    case unarmoredDefense
}

struct Skill: Codable {
    var name: String
    var description: String
    
    init(type: SkillType) {
        switch type {
        case .persuasion:
            name = "Persuasion"
            description = "If your charisma modifier + proficiency + 1D20 >= difficulty, the persuation is succeeded."
        case .greatWeaponFighting:
            name = "Great Weapon Fighting"
            description = "When you use two-handed weapon and rolled 1 or 2 on any damage dice, you can reroll it and accept the new result."
        case .unarmoredDefense:
            name = "Unarmoored Defense"
            description = "When you are not wearing armor, your constituion modifier will be added to your armor class."
        }
    }
}
