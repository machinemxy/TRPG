//
//  Action.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/08.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum TargetType {
    case no, ally, enemy
}

enum Action {
    case noAction
    case attack
    case bite
    case drinkPotionOfHealing
    case drinkAntidote
    case cure
    
    func perform(by battler: Battler, to target: Battler?) -> String {
        switch self {
        case .noAction:
            return ""
        case .attack:
            return performAttack(by: battler, to: target!)
        case .bite:
            return performAttack(by: battler, to: target!, verb: "bit", sideEffect: SideEffect(difficulty: 10, abilityToUse: .con, statusToAdd: .poisoned))
        case .drinkPotionOfHealing:
            let value = Int.abcCalc(a: 2, b: 4, c: 2)
            battler.addHP(by: value)
            Party.instance.loseItem(UsableItem.potionOfHealing)
            return "\(battler.name) drank potion of healing, recovered \(value) HP."
        case .drinkAntidote:
            battler.statuses.remove(.poisoned)
            Party.instance.loseItem(UsableItem.antidote)
            return "\(battler.name) drank antidote, recovered from poisoned status."
        case .cure:
            guard let target = target else { fatalError("no target") }
            
            // reduce battler's mp
            let cureC = battler.cha.modifier + battler.proficiency
            let curePoint = Int.abcCalc(a: 1, b: 8, c: cureC)
            target.addHP(by: curePoint)
            return "\(battler.name) cured \(target.name) for \(curePoint) HP."
        }
    }
    
    func description(target: Battler?) -> String {
        switch self {
        case .noAction:
            return ""
        case .attack:
            if let target = target {
                return "attack \(target.name)"
            } else {
                return "attack randomly"
            }
        case .bite:
            if let target = target {
                return "bite \(target.name)"
            } else {
                return "bite randomly"
            }
        case .drinkPotionOfHealing:
            return "drink potion"
        case .drinkAntidote:
            return "drink antidote"
        case .cure:
            if let target = target {
                return "cure \(target.name)"
            } else {
                return "cure randomly"
            }
        }
    }
    
    func targetType() -> TargetType {
        switch self {
        case .noAction:
            return .no
        case .attack:
            return .enemy
        case .bite:
            return .enemy
        case .drinkPotionOfHealing:
            return .no
        case .drinkAntidote:
            return .no
        case .cure:
            return .ally
        }
    }
    
    private func performAttack(by battler: Battler, to target: Battler, verb: String = "attacked", sideEffect: SideEffect? = nil) -> String {
        var log = ""
        
        log.append("\(battler.name) \(verb) \(target.name), ")
        let hitDice = Int.random(in: 1...20)
        
        // miss
        if hitDice == 1 || (hitDice != 20 && battler.hitBonus + hitDice < target.ac) {
            log.append("but failed to cause damage.")
            return log
        }
        
        // critical hit
        var damageAMultiplier = 1
        if hitDice == 20 {
            damageAMultiplier = 2
            log.append("critical hit, ")
        }
        
        // calculate damage
        let damage: Int
        if battler.skills.contains(.greatWeaponFighting),
            let pc = battler as? Pc,
            pc.weapon.needTwoHand == true {
            damage = Int.abcCalc(a: damageAMultiplier * battler.damageA, b: battler.damageB, c: battler.damageC, hasGreatWeaponFighting: true)
        } else {
            damage = Int.abcCalc(a: damageAMultiplier * battler.damageA, b: battler.damageB, c: battler.damageC)
        }
        log.append("caused \(damage) damage. ")
        target.reduceHP(by: damage)
        if target.isAlive {
            if let sideEffect = sideEffect {
                if sideEffect.savingRoll(by: target) == false {
                    log.append("\(target.name) was \(sideEffect.statusToAdd).")
                }
            }
        } else {
            log.append("\(target.name) was down.")
        }
        
        return log
    }
}
