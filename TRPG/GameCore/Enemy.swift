//
//  Enemy.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Enemy: Battler {
    static let rat = 0
    
    var name: String
    var mhp: Int
    var hp: Int
    var hitBonus: Int
    var minDamage: Int
    var maxDamage: Int
    var ac: Int
    var challenge: Int
    var dropItems: [Int]
    
    init(id: Int) {
        switch id {
        case Self.rat:
            name = "rat"
            mhp = 1
            hp = 1
            hitBonus = 0
            minDamage = 1
            maxDamage = 1
            ac = 10
            challenge = 0
            dropItems = []
        default:
            // dummy
            name = "dummy"
            mhp = 1
            hp = 1
            hitBonus = 0
            minDamage = 1
            maxDamage = 1
            ac = 10
            challenge = 0
            dropItems = []
        }
    }
}
