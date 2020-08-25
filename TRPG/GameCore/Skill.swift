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
}

struct Skill: Codable {
    var name: String
    var description: String
    
    init(type: SkillType) {
        switch type {
        case .persuasion:
            name = "Persuasion"
            description = "Persuade someone to change his mind. Your charisma will affect the success rate."
        }
    }
}
