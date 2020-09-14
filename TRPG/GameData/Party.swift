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
    
    var pcs = [Paladin.initLiuBei()]
    @Published var money: Int = 0
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
        money = try container.decode(Int.self, forKey: .money)
        inventories = try container.decode([Int: Int].self, forKey: .inventories)
        location = try container.decode(String.self, forKey: .location)
    }
    
    var itemIds: [Int] {
        inventories.keys.sorted()
    }
    
    var usableItemIds: [Int] {
        inventories.keys.filter { $0 >= 400 }
    }
    
    var otherItemIds: [Int] {
        inventories.keys.filter { $0 < 400 }
    }
    
    func gainExp(_ exp: Int) {
        let alivePcs = pcs.filter { $0.isAlive }
        guard alivePcs.count > 0 else { fatalError("All Pcs are dead") }
        
        let expEachPerson = exp / alivePcs.count
        for pc in alivePcs {
            pc.exp += expEachPerson
        }
    }
    
    func gainItems(_ items: [Int]) {
        for item in items {
            let quantity = inventories[item] ?? 0
            inventories.updateValue(quantity + 1, forKey: item)
        }
    }
    
    func gainItem(_ item: Int, amount: Int) {
        let quantity = inventories[item] ?? 0
        inventories.updateValue(quantity + amount, forKey: item)
    }
    
    func loseItem(_ itemId: Int) {
        if let itemCount = inventories[itemId], itemCount > 1 {
            inventories.updateValue(itemCount - 1, forKey: itemId)
        } else {
            inventories.removeValue(forKey: itemId)
        }
    }
    
    func loseItem(_ itemId: Int, amount: Int) {
        if let itemCount = inventories[itemId], itemCount > amount {
            inventories.updateValue(itemCount - amount, forKey: itemId)
        } else {
            inventories.removeValue(forKey: itemId)
        }
    }
    
    func rest() {
        for pc in pcs {
            pc.hp = pc.mhp
            pc.statuses.removeAll()
        }
    }
}
