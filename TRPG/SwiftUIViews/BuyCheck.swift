//
//  BuyCheck.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SwiftUI

struct BuyCheck: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var amount = 1
    var itemId: Int
    var party: Party
    var spent: Int {
        itemId.toItem().price * amount
    }
    var left: Int {
        party.money - spent
    }
    
    var body: some View {
        Form {
            Stepper("Amount: \(amount)", value: $amount, in: 1...99)
            
            HStack {
                Text("Money:")
                Text("\(party.money)cp")
                Text("-")
                Text("\(self.spent)cp")
                Text("=")
                Text("\(self.left)cp")
            }
            
            Button("Check") {
                self.party.gainItem(self.itemId, amount: self.amount)
                self.party.money -= self.spent
                self.presentationMode.wrappedValue.dismiss()
            }.disabled(left < 0)
        }.navigationBarTitle(itemId.toItem().name)
    }
}

struct BuyCheck_Previews: PreviewProvider {
    static var previews: some View {
        BuyCheck(itemId: 0, party: Party())
    }
}
