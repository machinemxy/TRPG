//
//  Pc.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Pc: Battler, Codable, ObservableObject {
    static let liuBei = "Liu Bei"
    
    enum CodingKeys: CodingKey {
        case name, str, dex, con, int, wis, cha, mhp, hp, lv, exp, weaponId, shieldId, armorId, skills, statuses
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(name, forKey: .name)
        try container.encode(str, forKey: .str)
        try container.encode(dex, forKey: .dex)
        try container.encode(con, forKey: .con)
        try container.encode(int, forKey: .int)
        try container.encode(wis, forKey: .wis)
        try container.encode(cha, forKey: .cha)
        try container.encode(mhp, forKey: .mhp)
        try container.encode(hp, forKey: .hp)
        try container.encode(lv, forKey: .lv)
        try container.encode(exp, forKey: .exp)
        try container.encode(weaponId, forKey: .weaponId)
        try container.encode(shieldId, forKey: .shieldId)
        try container.encode(armorId, forKey: .armorId)
        try container.encode(skills, forKey: .skills)
        try container.encode(statuses, forKey: .statuses)
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        name = try container.decode(String.self, forKey: .name)
        str = try container.decode(Int.self, forKey: .str)
        dex = try container.decode(Int.self, forKey: .dex)
        con = try container.decode(Int.self, forKey: .con)
        int = try container.decode(Int.self, forKey: .int)
        wis = try container.decode(Int.self, forKey: .wis)
        cha = try container.decode(Int.self, forKey: .cha)
        mhp = try container.decode(Int.self, forKey: .mhp)
        hp = try container.decode(Int.self, forKey: .hp)
        lv = try container.decode(Int.self, forKey: .lv)
        exp = try container.decode(Int.self, forKey: .exp)
        weaponId = try container.decode(Int?.self, forKey: .weaponId)
        shieldId = try container.decode(Int?.self, forKey: .shieldId)
        armorId = try container.decode(Int?.self, forKey: .armorId)
        skills = try container.decode([SkillType].self, forKey: .skills)
        statuses = try container.decode([Status].self, forKey: .statuses)
    }
    
    var name = ""
    @Published var str = 1
    @Published var dex = 1
    @Published var con = 1
    @Published var int = 1
    @Published var wis = 1
    @Published var cha = 1
    @Published var mhp = 1
    @Published var hp = 1
    @Published var lv = 1
    @Published var exp = 0
    @Published var weaponId: Int? = nil
    @Published var shieldId: Int? = nil
    @Published var armorId: Int? = nil
    @Published var skills = [SkillType]()
    @Published var statuses = [Status]()
    
    var weapon: Weapon {
        Weapon(id: weaponId)
    }
    
    var shield: Shield {
        Shield(id: shieldId)
    }
    
    var armor: Armor {
        Armor(id: armorId)
    }
    
    var requiredExp: Int {
        switch lv {
        case 1:
            return 300
        case 2:
            return 900
        case 3:
            return 2_700
        case 4:
            return 6_500
        case 5:
            return 14_000
        case 6:
            return 23_000
        case 7:
            return 34_000
        case 8:
            return 48_000
        case 9:
            return 64_000
        case 10:
            return 85_000
        case 11:
            return 100_000
        case 12:
            return 120_000
        case 13:
            return 140_000
        case 14:
            return 165_000
        case 15:
            return 195_000
        case 16:
            return 225_000
        case 17:
            return 265_000
        case 18:
            return 305_000
        case 19:
            return 355_000
        default:
            return Int.max
        }
    }
    
    var proficiency: Int {
        return (lv - 1) / 4 + 2
    }
    
    var hitBonus: Int {
        return str.modifier + proficiency
    }
    
    var damageA: Int {
        return weapon.damageA
    }
    
    var damageB: Int {
        return weapon.damageB
    }
    
    var damageC: Int {
        return str.modifier
    }
    
    var ac: Int {
        return dex.modifier + shield.ac + armor.ac
    }
    
    var lifeDice: Int {
        switch name {
        case Self.liuBei:
            return 10
        default:
            return 4
        }
    }
    
    var defaultAction: Action { .attack }
    
    var goodAtAbilities: [BasicAbility] {
        if name == Self.liuBei {
            return [.wis, .cha]
        } else {
            return [.str, .con]
        }
    }
    
    var statusDescription: String {
        if statuses.isEmpty {
            return "healthy"
        } else {
            return statuses.map({ $0.rawValue }).joined(separator: ",")
        }
    }
}
