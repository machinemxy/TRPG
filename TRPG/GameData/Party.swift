//
//  Party.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Party: Codable, ObservableObject {
    static var instance = Party()
    
    enum CodingKeys: CodingKey {
        case pcs, money, inventories, location
    }
    
    var pcs = [LiuBei.create()]
    var money: Double = 0
    @Published var inventories = [300: 10]
    var location = "Village"
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(pcs, forKey: .pcs)
        try container.encode(money, forKey: .money)
        try container.encode(inventories, forKey: .inventories)
        try container.encode(location, forKey: .location)
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        pcs = try container.decode([Pc].self, forKey: .pcs)
        money = try container.decode(Double.self, forKey: .money)
        inventories = try container.decode([Int: Int].self, forKey: .inventories)
        location = try container.decode(String.self, forKey: .location)
    }
    
    var usableItems: [Int] {
        return inventories.keys.filter { $0 >= 400 }
    }
    
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
    
    func loseItem(_ itemId: Int) {
        if let itemCount = inventories[itemId], itemCount > 1 {
            inventories.updateValue(itemCount - 1, forKey: itemId)
        } else {
            inventories.removeValue(forKey: itemId)
        }
    }
    
    func rest() {
        for pc in pcs {
            pc.hp = pc.mhp
        }
    }
}
