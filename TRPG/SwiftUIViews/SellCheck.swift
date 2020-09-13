//
//  SellCheck.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/13.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct SellCheck: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var amount = 1
    var itemId: Int
    var party: Party
    var ceiling: Int {
        party.inventories[itemId] ?? 1
    }
    var gain: Int {
        amount * itemId.toItem().price / 2
    }
    var after: Int {
        party.money + gain
    }
    
    var body: some View {
        Form {
            Stepper("Amount: \(amount)", value: $amount, in: 1...ceiling)
            
            HStack {
                Text("Money:")
                Text("\(party.money)cp")
                Text("+")
                Text("\(self.gain)cp")
                Text("=")
                Text("\(self.after)cp")
            }
            
            Button("Check") {
                self.party.loseItem(self.itemId, amount: self.amount)
                self.party.money += self.gain
                self.presentationMode.wrappedValue.dismiss()
            }
        }.navigationBarTitle(itemId.toItem().name)
    }
}

struct SellCheck_Previews: PreviewProvider {
    static var previews: some View {
        SellCheck(itemId: 300, party: Party())
    }
}
