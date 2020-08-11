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
}
