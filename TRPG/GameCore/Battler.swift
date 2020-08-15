//
//  Battler.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

protocol Battler {
    var name: String { get }
    var mhp: Int { get }
    var hp: Int { get }
    var hitBonus: Int { get }
    var minDamage: Int { get }
    var maxDamage: Int { get }
    var ac: Int { get }
}
