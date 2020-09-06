//
//  IntExt.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/10.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

extension Int {
    var modifier: Int {
        return self / 2 - 5
    }
    
    func toItem() -> Item {
        if self < 100 {
            return Weapon(id: self)
        } else if self < 200 {
            return Shield(id: self)
        } else if self < 300 {
            return Armor(id: self)
        } else if self < 400 {
            return UselessItem(id: self)
        } else {
            return UsableItem(id: self)
        }
    }
    
    /// Calculate the result of aDb + c
    static func abcCalc(a: Int, b: Int, c: Int) -> Int {
        var result = c
        for _ in 1...a {
            result += Int.random(in: 1...b)
        }
        return result
    }
}
