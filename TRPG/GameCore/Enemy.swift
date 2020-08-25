//
//  Enemy.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum EnemyType {
    case rat
}

class Enemy: Battler {
    var name: String
    var str: Int
    var dex: Int
    var con: Int
    var int: Int
    var wis: Int
    var cha: Int
    var mhp: Int
    var hp: Int
    var hitBonus: Int
    var minDamage: Int
    var maxDamage: Int
    var ac: Int
    var challenge: Int
    var dropItems: [Int]
    
    init(_ name: String, type: EnemyType) {
        self.name = name
        
        switch type {
        case .rat:
            str = 2
            dex = 11
            con = 9
            int = 2
            wis = 10
            cha = 4
            mhp = 1
            hitBonus = 0
            minDamage = 1
            maxDamage = 1
            ac = 10
            challenge = 0
            dropItems = []
        }
        
        hp = mhp
    }
}
