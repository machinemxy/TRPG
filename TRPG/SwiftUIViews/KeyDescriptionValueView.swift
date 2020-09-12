//
//  KeyDescriptionValueView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct KeyDescriptionValueView: View {
    var key: String
    var description: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(key)
                Text(description).font(.footnote)
            }
            
            Spacer()
            
            Text(value)
        }
    }
}

struct KeyDescriptionValueView_Previews: PreviewProvider {
    static var previews: some View {
        KeyDescriptionValueView(key: "A", description: "B", value: "C")
    }
}
