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

enum ChallengeRatting {
    case c0
    case c1_8
    case c1_4
    case c1_2
    case c1
    case c2
    case c3
    case c4
    case c5
    case c6
    case c7
    case c8
    case c9
    case c10
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
        }
        
        hp = mhp
    }
    
    var exp: Int {
        switch challenge {
        case .c0:
            return 10
        case .c1_8:
            return 25
        case .c1_4:
            return 50
        case .c1_2:
            return 100
        case .c1:
            return 200
        case .c2:
            return 450
        case .c3:
            return 700
        case .c4:
            return 1_100
        case .c5:
            return 1_800
        case .c6:
            return 2_300
        case .c7:
            return 2_900
        case .c8:
            return 3_900
        case .c9:
            return 5_000
        case .c10:
            return 5_900
        }
    }
}
