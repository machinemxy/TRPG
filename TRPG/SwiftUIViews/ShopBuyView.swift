//
//  ShopBuyView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct ShopBuyView: View {
    @ObservedObject var party: Party
    var itemIds: [Int]
    
    var body: some View {
        List {
            KeyValueView(key: "Money", value: String(format: "%.2fG", party.money))
            
            ForEach(itemIds, id: \.self, content: { itemId in
                NavigationLink(destination: Text("\(itemId)")) {
                    ShopItemView(item: itemId.toItem())
                }
            })
        }
        .navigationBarTitle(Text("Buy"))
    }
}

struct ShopBuyView_Previews: PreviewProvider {
    static var previews: some View {
        ShopBuyView(party: Party(), itemIds: [0, 1])
    }
}
