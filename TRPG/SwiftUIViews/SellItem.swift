//
//  SellItem.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/13.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct SellItem: View {
    var item: Item
    var count: Int
    
    var body: some View {
        KeyDescriptionValueView(key: "\(item.name)(\(count))", description: item.description, value: "\(item.price/2)cp")
    }
}

struct SellItem_Previews: PreviewProvider {
    static var previews: some View {
        SellItem(item: 400.toItem(), count: 3)
    }
}
