//
//  BattleViewController.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

enum BattleSituation {
    case inBattle
    case win
    case lose
}

class BattleViewController: UIViewController {
    @IBOutlet var sideViews: [SideView]!
    @IBOutlet weak var txtLog: UITextView!
    @IBOutlet weak var btnMain: UIButton!
    
    // attributes should be set before load
    var enemies: [Enemy]!
    var processAfterBattle: (() -> Void)?
    
    
    var isPcMoveFirst: Bool!
    var allPcsDead = false
    var allEnemiesDead = false
    var stillSomePcsAlive: Bool { !allPcsDead }
    var stillSomeEnemiesAlive: Bool { !allEnemiesDead }
    var log = ""
    var battleSituation = BattleSituation.inBattle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add layer to btnMain
        btnMain.layer.borderWidth = 1
        btnMain.layer.borderColor = UIColor.link.cgColor
        btnMain.backgroundColor = .secondarySystemBackground

        // set initial ui
        sideViews[0].setBattlers(Party.instance.pcs, isPc: true, target: enemies[0])
        sideViews[1].setBattlers(enemies, isPc: false)
        
        decideMoveOrder()
    }
    
    @IBAction func btnMainClicked(_ sender: Any) {
        switch battleSituation {
        case .inBattle:
            performActions()
        case .win:
            afterBattle()
        case .lose:
            DataManager.loadData()
            performSegue(withIdentifier: Key.gameOverSegue, sender: nil)
        }
    }
    
    private func decideMoveOrder() {
        let pcDexBonus = Party.instance.pcs.reduce(0) { $0 + $1.dex.modifier }
        let enemyDexBonus = enemies.reduce(0) { $0 + $1.dex.modifier }
        isPcMoveFirst = pcDexBonus + Int.random(in: 1...20) >= enemyDexBonus + Int.random(in: 1...20)
    }
    
    private func performActions() {
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
            changeBattleSituation(.lose)
            return
        }
        
        if allEnemiesDead {
            changeBattleSituation(.win)
        }
    }
    
    private func afterBattle() {
        let totalExp = enemies.reduce(0) { $0 + $1.exp }
        let totalItems = enemies.reduce(into: [Int]()) { $0.append(contentsOf: $1.dropItems) }
        Party.instance.gainExp(totalExp)
        Party.instance.gainItems(totalItems)
        
        // todo
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
        
        let hitDice = Int.random(in: 1...20)
        
        if hitDice == 1 || (hitDice != 20 && attacker.hitBonus + hitDice < target.ac) {
            log.append("but failed to cause damage.\n")
            return
        }
        
        var damageAMultiplier = 1
        if hitDice == 20 {
            damageAMultiplier = 2
            log.append("critical hit, ")
        }
        
        var damage = attacker.damageC
        for _ in 1...(damageAMultiplier * attacker.damageA) {
            damage += Int.random(in: 1...attacker.damageB)
        }
        
        log.append("caused \(damage) damage.")
        target.hp -= damage
        if target.hp <= 0 {
            target.hp = 0
            log.append("\(target.name) was down.")
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
    
    private func changeBattleSituation(_ situation: BattleSituation) {
        battleSituation = situation
        
        switch situation {
        case .inBattle:
            break // it won't happen
        case .win:
            btnMain.setTitleColor(.systemGreen, for: .normal)
            btnMain.layer.borderColor = UIColor.systemGreen.cgColor
            btnMain.setTitle("View reward", for: .normal)
        case .lose:
            btnMain.setTitleColor(.systemRed, for: .normal)
            btnMain.layer.borderColor = UIColor.systemRed.cgColor
            btnMain.setTitle("Restart from save point", for: .normal)
        }
    }
}
