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
    
    init(_ name: String, id: Int) {
        self.name = name
        
        switch id {
        case Self.rat:
            str = 2
            dex = 11
            con = 9
            int = 2
            wis = 10
            cha = 4
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
            str = 1
            dex = 1
            con = 1
            int = 1
            wis = 1
            cha = 1
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
