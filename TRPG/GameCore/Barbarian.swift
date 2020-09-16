//
//  Barbarian.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/16.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Barbarian {
    static func initZhangFei() -> Pc {
        let pc = Pc()
        
        pc.name = "Zhang Fei"
        pc.job = .barbarian
        pc.str = 16
        pc.dex = 13
        pc.con = 19
        pc.int = 12
        pc.wis = 14
        pc.cha = 15
        pc.mhp = 16
        pc.weaponId = Weapon.greatClub
        pc.skills.append(.unarmoredDefense)
        
        pc.hp = pc.mhp
        
        return pc
    }
    
    static func initWuAnguo() -> Pc {
        let pc = Pc()
        
        pc.name = "Wu Anguo"
        pc.job = .barbarian
        pc.str = 12
        pc.dex = 11
        pc.con = 16
        pc.int = 10
        pc.wis = 10
        pc.cha = 11
        pc.mhp = 15
        pc.weaponId = Weapon.greatClub
        pc.skills.append(.unarmoredDefense)
        
        pc.hp = pc.mhp
        
        return pc
    }
}
