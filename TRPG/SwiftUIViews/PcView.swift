//
//  PcView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/10.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct PcView: View {
    var pc: Pc
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarTitle(pc.name)
    }
}

struct PcView_Previews: PreviewProvider {
    static var previews: some View {
        PcView(pc: Pc(name: "Liu Bei", str: 12, dex: 12, con: 10, int: 12, wis: 14, cha: 17, lifeDice: 10))
    }
}
