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
    case snake
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
    var defaultAction: Action
    var challenge: ChallengeRatting
    var dropItems: [Int]
    var statuses: Set<Status> = []
    var job = Job.no
    var skills = [SkillType]()
    
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
            defaultAction = .attack
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
            defaultAction = .attack
            challenge = .c0
            dropItems = [UselessItem.yellowTurban, Weapon.club]
        case .snake:
            str = 2
            dex = 16
            con = 11
            int = 1
            wis = 10
            cha = 3
            mhp = 2
            hitBonus = 5
            damageA = 1
            damageB = 1
            damageC = 0
            ac = 13
            defaultAction = .bite
            challenge = .c1_8
            dropItems = [UselessItem.snakeSkin]
        }
        
        hp = mhp
    }
    
    var exp: Int {
        challenge.toExp()
    }
    
    var proficiency: Int {
        challenge.toProficiency()
    }
}
