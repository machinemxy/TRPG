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
    case drinkPotionOfHealing
    
    func perform(by battler: Battler, to target: Battler?) -> String {
        switch self {
        case .noAction:
            return ""
        case .attack:
            return performAttack(by: battler, to: target!)
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
        case .drinkPotionOfHealing:
            return false
        }
    }
    
    private func performAttack(by battler: Battler, to target: Battler) -> String {
        var log = ""
        
        log.append("\(battler.name) attacked \(target.name), ")
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
        log.append("caused \(damage) damage.")
        target.reduceHP(by: damage)
        if !target.isAlive {
            log.append("\(target.name) was down.")
        }
        
        return log
    }
}
