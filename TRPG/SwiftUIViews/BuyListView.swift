//
//  BuyListView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct BuyListView: View {
    @ObservedObject var party: Party
    var itemIds: [Int]
    
    var body: some View {
        List {
            KeyValueView(key: "Money", value: "\(party.money)cp")
            
            ForEach(itemIds, id: \.self, content: { itemId in
                NavigationLink(destination: BuyCheck(itemId: itemId, party: self.party)) {
                    BuyItem(item: itemId.toItem())
                }
            })
        }
        .navigationBarTitle(Text("Buy"))
    }
}

struct BuyListView_Previews: PreviewProvider {
    static var previews: some View {
        BuyListView(party: Party(), itemIds: [0, 1])
    }
}
