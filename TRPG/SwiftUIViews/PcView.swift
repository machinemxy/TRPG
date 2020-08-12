//
//  PcView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/10.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct PcView: View {
    var pc: Pc
    
    var body: some View {
        Form {
            Section(header: Text("Basic")) {
                HStack {
                    Text("Lv")
                    Spacer()
                    Text("\(pc.lv)")
                    Button("Level up") {
                        print("level up!")
                    }.disabled(pc.exp < pc.requiredExp)
                }
                KeyValueView(key: "Exp", value: "\(pc.exp)/\(pc.requiredExp)")
                KeyValueView(key: "HP", value: "\(pc.hp)/\(pc.mhp)")
                KeyValueView(key: "Strength", value: "\(pc.str)")
                KeyValueView(key: "Dexterity", value: "\(pc.dex)")
                KeyValueView(key: "Constitution", value: "\(pc.con)")
                KeyValueView(key: "Intelligence", value: "\(pc.int)")
                KeyValueView(key: "Wisdom", value: "\(pc.wis)")
                KeyValueView(key: "Charisma", value: "\(pc.cha)")
            }
            
            Section(header: Text("Equipment")) {
                KeyValueView(key: "Weapon", value: "\(pc.weapon.name)")
                KeyValueView(key: "Shield", value: "\(pc.shield.name)")
                KeyValueView(key: "Armor", value: "\(pc.armor.name)")
            }
            
            Section(header: Text("Combat")) {
                KeyValueView(key: "Hit bonus", value: "\(pc.hitBonus)")
                KeyValueView(key: "Damage", value: "\(pc.minDamage) ~ \(pc.maxDamage)")
                KeyValueView(key: "Armor class", value: "\(pc.ac)")
            }
        }
        .navigationBarTitle(pc.name)
    }
}

struct PcView_Previews: PreviewProvider {
    static var previews: some View {
        let pc = Pc(name: "Liu Bei", str: 12, dex: 12, con: 10, int: 12, wis: 14, cha: 17, lifeDice: 10)
        pc.weaponId = Weapon.club
        return PcView(pc: pc)
    }
}
