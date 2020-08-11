//
//  KeyValueView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/11.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct KeyValueView: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
        }
    }
}

struct KeyValueView_Previews: PreviewProvider {
    static var previews: some View {
        KeyValueView(key: "Key", value: "Value")
    }
}
