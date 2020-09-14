//
//  PcView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/10.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct PcView: View {
    @ObservedObject var pc: Pc
    
    var body: some View {
        Form {
            Section(header: Text("Basic")) {
                KeyValueView(key: "Class", value: pc.job.rawValue)
                HStack {
                    Text("Lv")
                    Spacer()
                    Text("\(pc.lv)")
                    Button("Level up") {
                        print("level up!")
                    }.disabled(pc.exp < pc.requiredExp)
                }
                KeyValueView(key: "Exp", value: String(numerator: pc.exp, denominator: pc.requiredExp))
                KeyValueView(key: "HP", value: String(numerator: pc.hp, denominator: pc.mhp))
                KeyValueView(key: "Status", value: pc.statusDescription)
            }
            
            Section(header: Text("Abilities")) {
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
                KeyValueView(key: "Damage", value: "\(pc.damageA)D\(pc.damageB) + \(pc.damageC)")
                KeyValueView(key: "Armor class", value: "\(pc.ac)")
            }
            
            Section(header: Text("Skills")) {
                ForEach(pc.skills, id: \.self) { skillType in
                    VStack(alignment: .leading) {
                        Text(Skill(type: skillType).name)
                        Text(Skill(type: skillType).description).font(.footnote)
                    }
                }
            }
        }
        .navigationBarTitle(pc.name)
        .navigationBarItems(trailing:
            NavigationLink(destination: ItemListView(pc: pc, party: Party.instance), label: {
                Text("Item")
            })
        )
    }
}

struct PcView_Previews: PreviewProvider {
    static var previews: some View {
        let pc = Paladin.initLiuBei()
        return PcView(pc: pc)
    }
}
