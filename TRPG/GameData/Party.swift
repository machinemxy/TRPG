//
//  Party.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Party: Codable {
    static var instance = Party()
    
    var pcs = [LiuBei.create()]
    var money: Double = 0
    var inventories = [300: 10]
    var location = "Village"
    
    func gainExp(_ exp: Int) {
        guard pcs.count > 0 else { return }
        
        let expEachPerson = exp / pcs.count
        for pc in pcs {
            pc.exp += expEachPerson
        }
    }
    
    func gainItems(_ items: [Int]) {
        for item in items {
            let quantity = inventories[item] ?? 0
            inventories.updateValue(quantity + 1, forKey: item)
        }
    }
    
    func rest() {
        for pc in pcs {
            pc.hp = pc.mhp
        }
    }
}
