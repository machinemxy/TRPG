//
//  Fighter.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Fighter {
    static func initGuanYu() -> Pc {
        let pc = Pc()
        
        pc.name = "Guan Yu"
        pc.job = .fighter
        pc.str = 18
        pc.dex = 16
        pc.con = 14
        pc.int = 12
        pc.wis = 15
        pc.cha = 16
        pc.mhp = 12
        pc.weaponId = Weapon.greatClub
        pc.skills.append(.greatWeaponFighting)
        
        pc.hp = pc.mhp
        
        return pc
    }
    
    static func initPanFeng() -> Pc {
        let pc = Pc()
        
        pc.name = "Pan Feng"
        pc.job = .fighter
        pc.str = 16
        pc.dex = 13
        pc.con = 14
        pc.int = 12
        pc.wis = 12
        pc.cha = 10
        pc.mhp = 12
        pc.weaponId = Weapon.greatClub
        pc.skills.append(.greatWeaponFighting)
        
        pc.hp = pc.mhp
        
        return pc
    }
}
