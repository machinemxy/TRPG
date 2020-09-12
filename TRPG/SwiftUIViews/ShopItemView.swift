//
//  ShopItemView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct ShopItemView: View {
    var item: Item
    
    var body: some View {
        KeyDescriptionValueView(key: item.name, description: item.description, value: String(format: "%.2fG", item.price))
    }
}

struct ShopItemView_Previews: PreviewProvider {
    static var previews: some View {
        ShopItemView(item: 400.toItem())
    }
}
