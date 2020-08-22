//
//  BattleViewController.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

class BattleViewController: UIViewController {
    @IBOutlet var sideViews: [SideView]!
    @IBOutlet weak var txtLog: UITextView!
    
    var enemies: [Enemy]!
    var isPcMoveFirst: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set initial ui
        sideViews[0].setBattlers(Party.instance.pcs, isPc: true)
        sideViews[1].setBattlers(enemies, isPc: false)
        
        decideMoveOrder()
    }
    
    @IBAction func performActions(_ sender: Any) {
    }
    
    private func decideMoveOrder() {
        let pcDexBonus = Party.instance.pcs.reduce(0) { $0 + $1.dex.modifier }
        let enemyDexBonus = enemies.reduce(0) { $0 + $1.dex.modifier }
        isPcMoveFirst = pcDexBonus + Int.random(in: 1...20) >= enemyDexBonus + Int.random(in: 1...20)
    }
}
