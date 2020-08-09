//
//  AppDelegate.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let decoder = JSONDecoder()
        
        // load event trigger, or create it
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
            let liubei = Pc(name: "Liu Bei", str: 12, dex: 12, con: 10, int: 12, wis: 14, cha: 17, mhp: 8)
            Party.instance.pcs.append(liubei)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

