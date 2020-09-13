//
//  SellListView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/13.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct SellListView: View {
    @ObservedObject var party: Party
    
    var body: some View {
        List {
            KeyValueView(key: "Money", value: "\(party.money)cp")
            
            ForEach(party.itemIds, id: \.self, content: { itemId in
                NavigationLink(destination: SellCheck(itemId: itemId, party: self.party)) {
                    SellItem(item: itemId.toItem(), count: self.party.inventories[itemId]!)
                }
            })
        }.navigationBarTitle(Text("Sell"))
    }
}

struct SellListView_Previews: PreviewProvider {
    static var previews: some View {
        SellListView(party: Party())
    }
}
