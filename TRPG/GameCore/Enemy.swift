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
    case YTRecruit
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
    var damageA: Int
    var damageB: Int
    var damageC: Int
    var ac: Int
    var challenge: ChallengeRatting
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
            damageA = 1
            damageB = 1
            damageC = 0
            ac = 10
            challenge = .c0
            dropItems = []
        case .YTRecruit:
            str = 10
            dex = 10
            con = 10
            int = 10
            wis = 10
            cha = 10
            mhp = 4
            hitBonus = 2
            damageA = 1
            damageB = 4
            damageC = 0
            ac = 10
            challenge = .c0
            dropItems = [UselessItem.yellowTurban]
        }
        
        hp = mhp
    }
    
    var exp: Int {
        challenge.toExp()
    }
}
