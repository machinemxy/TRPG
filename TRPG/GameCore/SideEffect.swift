//
//  SideEffect.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

struct SideEffect {
    var difficulty: Int
    var abilityToUse: BasicAbility
    var statusToAdd: Status
    
    func savingRoll(by roller: Battler) -> Bool {
        var point = Int.random(in: 1...20)
        
        if roller.goodAtAbilities.contains(abilityToUse) {
            point += roller.proficiency
        }
        
        switch abilityToUse {
        case .str:
            point += roller.str.modifier
        case .dex:
            point += roller.dex.modifier
        case .con:
            point += roller.con.modifier
        case .int:
            point += roller.int.modifier
        case .wis:
            point += roller.wis.modifier
        case .cha:
            point += roller.cha.modifier
        }
        
        if point >= difficulty {
            return true
        } else {
            roller.statuses.insert(.poisoned)
            return false
        }
    }
}
