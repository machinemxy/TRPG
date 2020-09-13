//
//  BuyItemView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct BuyItem: View {
    var item: Item
    
    var body: some View {
        KeyDescriptionValueView(key: item.name, description: item.description, value: "\(item.price)cp")
    }
}

struct BuyItemView_Previews: PreviewProvider {
    static var previews: some View {
        BuyItem(item: 400.toItem())
    }
}
