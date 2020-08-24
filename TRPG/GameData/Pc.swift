//
//  Pc.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Pc: Codable, Battler {
    static let liuBei = 0
    
    init(id: Int) {
        switch id {
        case Self.liuBei:
            name = "Liu Bei"
            str = 12
            dex = 12
            con = 10
            int = 12
            wis = 14
            cha = 17
            lifeDice = 10
            weaponId = Weapon.club
            skills.append(Skill.persuasion)
        default:
            name = "dummy"
            str = 1
            dex = 1
            con = 1
            int = 1
            wis = 1
            cha = 1
            lifeDice = 10
        }
        
        mhp = lifeDice + con.modifier
        hp = mhp
    }
    
    var name: String
    var str: Int
    var dex: Int
    var con: Int
    var int: Int
    var wis: Int
    var cha: Int
    var lifeDice: Int
    var mhp: Int
    var hp: Int
    var lv = 1
    var exp = 0
    var weaponId = Weapon.bareHand
    var shiedId = Shield.none
    var armorId = Armor.none
    var skills = [Int]()
    
    var weapon: Weapon {
        Weapon(id: weaponId)
    }
    
    var shield: Shield {
        Shield(id: shiedId)
    }
    
    var armor: Armor {
        Armor(id: armorId)
    }
    
    var requiredExp: Int {
        switch lv {
        case 1:
            return 300
        case 2:
            return 900
        case 3:
            return 2_700
        case 4:
            return 6_500
        case 5:
            return 14_000
        case 6:
            return 23_000
        case 7:
            return 34_000
        case 8:
            return 48_000
        case 9:
            return 64_000
        case 10:
            return 85_000
        case 11:
            return 100_000
        case 12:
            return 120_000
        case 13:
            return 140_000
        case 14:
            return 165_000
        case 15:
            return 195_000
        case 16:
            return 225_000
        case 17:
            return 265_000
        case 18:
            return 305_000
        case 19:
            return 355_000
        default:
            return Int.max
        }
    }
    
    var proficiency: Int {
        return (lv - 1) / 4 + 2
    }
    
    var hitBonus: Int {
        return str.modifier + proficiency
    }
    
    var minDamage: Int {
        return str.modifier + weapon.minDamage
    }
    
    var maxDamage: Int {
        return str.modifier + weapon.maxDamage
    }
    
    var ac: Int {
        return dex.modifier + shield.ac + armor.ac
    }
}
