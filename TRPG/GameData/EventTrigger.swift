//
//  EventTrigger.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

enum EventTriggerKey: Int {
    case neighborJoinedYellowTurbans = 0 // 1:joined; 2:not joined
    case killedRat = 1 // 1:killed; 2:picked up potion
    case VillageTownDirection = 2 // 0: from village to town; 2: from town to village
    case shoesSold = 3
    case drugStoreMissionFinished = 4
    case metPartners = 5 // 1: partners are Guan Yu and Zhang Fei; 2: parnters are Pan Feng and Wu Anguo
}

class EventTrigger {
    static var array = [Int]()
    
    static func getValue(key: EventTriggerKey) -> Int {
        return array[key.rawValue]
    }
    
    static func setValue(key: EventTriggerKey, value: Int) {
        array[key.rawValue] = value
    }
}
