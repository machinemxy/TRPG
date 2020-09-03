//
//  ItemListView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/03.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    var body: some View {
        List(Party.instance.inventories.keys.sorted(), id: \.self) { inventoryKey in
            HStack {
                VStack(alignment: .leading) {
                    Text(inventoryKey.toItem().name)
                    Text(inventoryKey.toItem().description).font(.footnote)
                }
                
                Spacer()
                
                Text(String(Party.instance.inventories[inventoryKey]!))
            }
        }
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView()
    }
}
