//
//  Action.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/08.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum Action {
    case noAction
    case attack
    case bite
    case drinkPotionOfHealing
    
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
        }
    }
    
    func requireTarget() -> Bool {
        switch self {
        case .noAction:
            return false
        case .attack:
            return true
        case .bite:
            return true
        case .drinkPotionOfHealing:
            return false
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
        let damage = Int.abcCalc(a: damageAMultiplier * battler.damageA, b: battler.damageB, c: battler.damageC)
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
