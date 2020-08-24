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
    @IBOutlet weak var btnPerformActions: UIButton!
    
    var enemies: [Enemy]!
    var isPcMoveFirst: Bool!
    var allPcsDead = false
    var allEnemiesDead = false
    var stillSomePcsAlive: Bool { !allPcsDead }
    var stillSomeEnemiesAlive: Bool { !allEnemiesDead }
    var log = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // set initial ui
        sideViews[0].setBattlers(Party.instance.pcs, isPc: true, target: enemies[0])
        sideViews[1].setBattlers(enemies, isPc: false)
        
        decideMoveOrder()
    }
    
    @IBAction func performActions(_ sender: Any) {
        log = ""
        
        if isPcMoveFirst {
            performPcActions()
            if stillSomePcsAlive && stillSomeEnemiesAlive {
                performEnemyActions()
            }
        } else {
            performEnemyActions()
            if stillSomePcsAlive && stillSomeEnemiesAlive {
                performPcActions()
            }
        }
        
        updateUI()
        
        if allPcsDead {
            btnPerformActions.isEnabled = false
            performSegue(withIdentifier: "unwindToMap", sender: nil)
            return
        }
        
        if allEnemiesDead {
            btnPerformActions.isEnabled = false
            performSegue(withIdentifier: "unwindToMap", sender: nil)
        }
    }
    
    private func decideMoveOrder() {
        let pcDexBonus = Party.instance.pcs.reduce(0) { $0 + $1.dex.modifier }
        let enemyDexBonus = enemies.reduce(0) { $0 + $1.dex.modifier }
        isPcMoveFirst = pcDexBonus + Int.random(in: 1...20) >= enemyDexBonus + Int.random(in: 1...20)
    }
    
    private func performPcActions() {
        for i in 0...2 {
            let pcView = sideViews[0].battlerViews[i]
            guard let battler = pcView.battler, battler.hp > 0 else { continue }
            
            if pcView.action == "attack" {
                if let target = pcView.target, target.hp > 0 {
                    performAttack(attacker: battler, target: target)
                } else {
                    let target = enemies.filter { $0.hp > 0 }.randomElement()
                    performAttack(attacker: battler, target: target!)
                }
            }
            
            checkDeadOrAlive()
            if allPcsDead || allEnemiesDead {
                break
            }
        }
    }
    
    private func performEnemyActions() {
        for i in 0...2 {
            let enemyView = sideViews[1].battlerViews[i]
            guard let battler = enemyView.battler, battler.hp > 0 else { continue }
            
            let target = Party.instance.pcs.filter { $0.hp > 0 }.randomElement()
            performAttack(attacker: battler, target: target!)
            
            checkDeadOrAlive()
            if allPcsDead || allEnemiesDead {
                break
            }
        }
    }
    
    private func performAttack(attacker: Battler, target: Battler) {
        log.append("\(attacker.name) attacked \(target.name), ")
        if attacker.hitBonus + Int.random(in: 1...20) >= target.ac {
            let damage = Int.random(in: attacker.minDamage...attacker.maxDamage)
            log.append("caused \(damage) damage.")
            target.hp -= damage
            if target.hp <= 0 {
                target.hp = 0
                log.append("\(target.name) was down.")
            }
        } else {
            log.append("but failed to cause damage.")
        }
        log.append("\n")
    }
    
    private func checkDeadOrAlive() {
        if Party.instance.pcs.first(where: { $0.hp > 0 }) == nil {
            allPcsDead = true
        }
        
        if enemies.first(where: { $0.hp > 0 }) == nil {
            allEnemiesDead = true
        }
    }
    
    private func updateUI() {
        txtLog.text = log
        
        for sideView in sideViews {
            for battlerView in sideView.battlerViews {
                guard let battler = battlerView.battler else { continue }
                if battler.hp == 0 {
                    if battlerView.btnAction.isEnabled == true {
                        battlerView.btnAction.setTitle("-", for: .normal)
                        battlerView.btnAction.isEnabled = false
                    }
                    battlerView.lblName.textColor = .secondaryLabel
                }
                
                battlerView.updateHP()
            }
        }
    }
}
