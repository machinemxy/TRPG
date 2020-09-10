//
//  Battler.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

protocol Battler: class {
    var name: String { get }
    var str: Int { get }
    var dex: Int { get }
    var con: Int { get }
    var int: Int { get }
    var wis: Int { get }
    var cha: Int { get }
    var mhp: Int { get }
    var hp: Int { get set }
    var hitBonus: Int { get }
    var damageA: Int { get }
    var damageB: Int { get }
    var damageC: Int { get }
    var ac: Int { get }
    var defaultAction: Action { get }
    var statuses: Set<Status> { get set }
    var goodAtAbilities: [BasicAbility] { get }
    var proficiency: Int { get }
}

extension Battler {
    var isAlive: Bool {
        hp > 0
    }
    
    func addHP(by value: Int) {
        if hp + value >= mhp {
            hp = mhp
        } else {
            hp += value
        }
    }
    
    func reduceHP(by value: Int) {
        if hp - value <= 0 {
            hp = 0
        } else {
            hp -= value
        }
    }
}
