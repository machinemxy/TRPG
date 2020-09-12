//
//  ItemView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/06.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    var count: Int
    
    var body: some View {
        KeyDescriptionValueView(key: item.name, description: item.description, value: String(count))
    }
}

struct UsefulItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: 400.toItem(), count: 5)
    }
}
