//
//  ItemListView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/03.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    var pc: Pc
    @ObservedObject var party: Party
    
    @State private var showUseItemAlert = false
    @State private var selectedItemId = 0
    @State private var showCommonAlert = false
    @State private var commonAlertTitle = ""
    
    var body: some View {
        List {
            Section(header: Text("Usable item")) {
                ForEach(party.usableItemIds, id: \.self) { itemId in
                    Button(action: {
                        self.selectedItemId = itemId
                        self.showUseItemAlert = true
                    }) {
                        ItemView(item: itemId.toItem(), count: self.party.inventories[itemId]!)
                    }
                }
            }.alert(isPresented: $showUseItemAlert) {
                Alert(title: Text("Action"), primaryButton: .default(Text("Use"), action: {
                    let usableItem = self.selectedItemId.toUsableItem()
                    let useAction = usableItem.useAction
                    self.commonAlertTitle = useAction.perform(by: self.pc, to: nil)
                    NotificationCenter.default.post(name: .HPUpdated, object: nil)
                    self.showCommonAlert = true
                }), secondaryButton: .cancel())
            }
            
            Section(header: Text("Others")) {
                ForEach(party.otherItemIds, id: \.self) { itemId in
                    ItemView(item: itemId.toItem(), count: self.party.inventories[itemId]!)
                }
            }
        }.alert(isPresented: $showCommonAlert) { () -> Alert in
            Alert(title: Text(commonAlertTitle))
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(pc: Paladin.initLiuBei(), party: Party())
    }
}
