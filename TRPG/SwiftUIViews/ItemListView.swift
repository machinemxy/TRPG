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
                ForEach(party.usableItems, id: \.self) { itemId in
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
                    self.commonAlertTitle = usableItem.used(by: self.pc)
                    self.party.loseItem(self.selectedItemId)
                    self.showCommonAlert = true
                }), secondaryButton: .cancel())
            }
        }.alert(isPresented: $showCommonAlert) { () -> Alert in
            Alert(title: Text(commonAlertTitle))
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(pc: LiuBei.create(), party: Party())
    }
}
