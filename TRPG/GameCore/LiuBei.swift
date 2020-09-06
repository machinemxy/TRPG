//
//  LiuBei.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/25.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

class LiuBei {
    static func create() -> Pc {
        let pc = Pc()
        
        pc.name = Pc.liuBei
        pc.str = 12
        pc.dex = 12
        pc.con = 10
        pc.int = 12
        pc.wis = 14
        pc.cha = 17
        pc.mhp = 10
        pc.weaponId = Weapon.club
        pc.skills.append(.persuasion)
        
        pc.hp = pc.mhp
        
        return pc
    }
}
