//
//  Pc.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Pc: Codable {
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
    
    init(name: String, str: Int, dex:Int, con: Int, int: Int, wis: Int, cha:Int, lifeDice: Int) {
        self.name = name
        self.str = str
        self.dex = dex
        self.con = con
        self.int = int
        self.wis = wis
        self.cha = cha
        self.lifeDice = lifeDice
        mhp = lifeDice + con.modifier
        hp = mhp
    }
    
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
