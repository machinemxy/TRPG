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

class BattleViewController: UIViewController, MapVCDelegate {
    @IBOutlet var sideViews: [SideView]!
    @IBOutlet weak var txtLog: UITextView!
    @IBOutlet weak var btnMain: UIButton!
    
    // attributes should be set before load
    var enemies = [Enemy]()
    var processAfterBattle: (() -> Void)?
    
    
    var isPcMoveFirst: Bool!
    var allPcsDead = false
    var allEnemiesDead = false
    var log = ""
    var battleSituation = BattleSituation.inBattle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // add layer to btnMain
        btnMain.layer.borderWidth = 1
        btnMain.layer.borderColor = UIColor.link.cgColor
        btnMain.backgroundColor = .secondarySystemBackground

        // set initial ui
        sideViews[0].setBattlers(Party.instance.pcs, isPc: true)
        sideViews[1].setBattlers(enemies, isPc: false)
        
        // set delegate
        for i in 0...2 {
            sideViews[0].battlerViews[i].mapVCDelegate = self
        }
        
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
        
        let firstMoveSide: Int
        let secondMoveSide: Int
        if isPcMoveFirst {
            firstMoveSide = 0
            secondMoveSide = 1
        } else {
            firstMoveSide = 1
            secondMoveSide = 0
        }
        
        performActionsOfSide(firstMoveSide)
        if !(allPcsDead || allEnemiesDead) {
            performActionsOfSide(secondMoveSide)
        }
        
        poisonProcess()
        
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
        
        var message = "Exp gained: \(totalExp)"
        if totalItems.count > 0 {
            let items = totalItems.map { $0.toItem().name }.joined(separator: ", ")
            message.append("\nItem gained: \(items)")
        }
        
        let ac = UIAlertController(title: "Reward", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
            if let processAfterBattle = self.processAfterBattle {
                processAfterBattle()
            }
            self.performSegue(withIdentifier: Key.unwindToMapSegue, sender: nil)
        }))
        present(ac, animated: true)
    }
    
    private func performActionsOfSide(_ sideId: Int) {
        let opponentSideId = 1 - sideId
        let opponents = sideViews[opponentSideId].battlers!
        for i in 0...2 {
            let battlerView = sideViews[sideId].battlerViews[i]
            guard let battler = battlerView.battler, battler.isAlive else { continue }
            
            let logLine: String
            if battlerView.action.requireTarget() {
                if let target = battlerView.target, target.isAlive {
                    logLine = battlerView.action.perform(by: battler, to: target)
                } else {
                    let tempTarget = opponents.filter({ $0.isAlive }).randomElement()
                    logLine = battlerView.action.perform(by: battler, to: tempTarget)
                }
            } else {
                logLine = battlerView.action.perform(by: battler, to: battlerView.target)
            }
            log.append(logLine)
            log.append("\n")
            
            checkDeadOrAlive()
            if allPcsDead || allEnemiesDead {
                break
            }
        }
    }
    
    private func checkDeadOrAlive() {
        if Party.instance.pcs.first(where: { $0.isAlive }) == nil {
            allPcsDead = true
        }
        
        if enemies.first(where: { $0.isAlive}) == nil {
            allEnemiesDead = true
        }
    }
    
    private func poisonProcess() {
        for sideView in sideViews {
            for battlerView in sideView.battlerViews {
                guard let battler = battlerView.battler, battler.isAlive, battler.statuses.contains(.poisoned) else { continue }
                battler.reduceHP(by: 1)
                log.append("\(battler.name) got 1 poison damage.\n")
            }
        }
    }
    
    private func updateUI() {
        txtLog.text = log
        
        for sideView in sideViews {
            for battlerView in sideView.battlerViews {
                guard let battler = battlerView.battler else { continue }
                if battler.isAlive {
                    // if the character is a alived pc
                    if battlerView.btnAction.isEnabled {
                        // if pc's action is not attack, or his target is dead, reset his action
                        var actionOrTargetChanged = false
                        if battlerView.action != .attack {
                            battlerView.action = .attack
                            actionOrTargetChanged = true
                        }
                        
                        if let target = battlerView.target, target.isAlive == false {
                            battlerView.target = nil
                            actionOrTargetChanged = true
                        }
                        
                        if actionOrTargetChanged {
                            battlerView.updateBtnActionTitle()
                        }
                    }
                } else {
                    // the character is just dead
                    if battlerView.action != .noAction {
                        battlerView.action = .noAction
                        battlerView.updateBtnActionTitle()
                        battlerView.btnAction.isEnabled = false
                        battlerView.lblName.textColor = .secondaryLabel
                    }
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
    
    func alert(ac: UIAlertController) {
        present(ac, animated: true)
    }
}
