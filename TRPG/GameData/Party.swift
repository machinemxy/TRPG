//
//  Party.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class Party: Codable {
    static var instance = Party()
    
    var pcs = [Pc]()
    var money = 0
    
    func gainExp(_ exp: Int) {
        guard pcs.count > 0 else { return }
        
        let expEachPerson = exp / pcs.count
        for pc in pcs {
            pc.exp += expEachPerson
        }
    }
}
