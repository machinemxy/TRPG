//
//  DataManager.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/25.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import Foundation

class DataManager {
    static func saveData() -> Bool {
        let encoder = JSONEncoder()
        
        if let eventTriggerData = try? encoder.encode(EventTrigger.array) {
            UserDefaults.standard.set(eventTriggerData, forKey: Key.eventTrigger)
        } else {
            return false
        }
        
        if let partyData = try? encoder.encode(Party.instance) {
            UserDefaults.standard.set(partyData, forKey: Key.party)
        } else {
            return false
        }
        
        return true
    }
    
    static func loadData() {
        let decoder = JSONDecoder()
        
        if let eventTriggerData = UserDefaults.standard.data(forKey: Key.eventTrigger),
            let array = try? decoder.decode([Int].self, from: eventTriggerData) {
            EventTrigger.array = array
        } else {
            EventTrigger.array = Array(repeating: 0, count: 100)
        }
        
        // load party, or create it
        if let partyData = UserDefaults.standard.data(forKey: Key.party),
            let party = try? decoder.decode(Party.self, from: partyData) {
            Party.instance = party
        } else {
            Party.instance = Party()
        }
    }
    
    static func initData() {
        EventTrigger.array = Array(repeating: 0, count: 100)
        Party.instance = Party()
    }
}
