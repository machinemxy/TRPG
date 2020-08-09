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
    var mhp: Int
    var hp: Int
    var lv = 1
    var exp = 0
    
    init(name: String, str: Int, dex:Int, con: Int, int: Int, wis: Int, cha:Int, mhp: Int) {
        self.name = name
        self.str = str
        self.dex = dex
        self.con = con
        self.int = int
        self.wis = wis
        self.cha = cha
        self.mhp = mhp
        self.hp = mhp
    }
}
