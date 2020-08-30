//
//  EventTrigger.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class EventTrigger {
    static var array = [Int]()
    
    static let neighborJoinYellowTurbans = 0 // 1:joined; 2:not joined
    static let killedRat = 1 // 1:killed; 2:picked up potion
    static let fromVillageToTown = 2 // 0: from village to town; 2: from town to village
}
