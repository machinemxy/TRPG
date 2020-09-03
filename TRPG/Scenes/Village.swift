//
//  Village.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit
import UIKit

class Village: SKScene {
    var neighbor: SKNode!
    var rat: SKNode!
    var potion: SKNode!
    var leave: SKNode!
    
    override func didMove(to view: SKView) {
        neighbor = childNode(withName: "neighbor")
        rat = childNode(withName: "rat")
        potion = childNode(withName: "potion")
        
        setVisible()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "mother" {
                motherDialog()
            } else if node.name == "neighbor" {
                neighborDialog()
            } else if node.name == "villager1" {
                villager1Dialog()
            } else if node.name == "villager2" {
                villager2Dialog()
            } else if node.name == "villager" {
                villager3Dialog()
            } else if node.name == "rest" {
                rest()
            } else if node.name == "rat" {
                ratBattle()
            } else if node.name == "potion" {
                pickupPotion()
            } else if node.name == "leave" {
                switchScene(fileNamed: "Path")
            }
        }
    }
    
    private func motherDialog() {
        let ac = UIAlertController(title: "Liu Bei:", message: "mother_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction.next {
            let ac2 = UIAlertController(title: "mother:", message: "mother_2".localized(), preferredStyle: .alert)
            ac2.addAction(UIAlertAction.ok)
            MapViewController.presentAlert(ac2)
        })
        MapViewController.presentAlert(ac)
    }
    
    private func neighborDialog() {
        if EventTrigger.array[EventTrigger.neighborJoinYellowTurbans] == 0 {
            let ac = UIAlertController(title: "neighbor:", message: "neighbor_1".localized(), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let him go", style: .default, handler: { (_) in
                let ac2 = UIAlertController(title: "neighbor:", message: "neighbor_2".localized(), preferredStyle: .alert)
                ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                    EventTrigger.array[EventTrigger.neighborJoinYellowTurbans] = 1
                    self.neighbor.isHidden = true
                }))
                MapViewController.presentAlert(ac2)
            }))
            ac.addAction(UIAlertAction(title: "Persuade him not go [difficulty 10]", style: .default, handler: { [unowned self] (_) in
                if self.persuade(target: 10) {
                    let ac2 = UIAlertController(title: "neighbor:", message: "neighbor_3".localized(), preferredStyle: .alert)
                    ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        EventTrigger.array[EventTrigger.neighborJoinYellowTurbans] = 2
                        Party.instance.gainExp(100)
                    }))
                    MapViewController.presentAlert(ac2)
                } else {
                    let ac2 = UIAlertController(title: "neighbor:", message: "neighbor_5".localized(), preferredStyle: .alert)
                    ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                        EventTrigger.array[EventTrigger.neighborJoinYellowTurbans] = 1
                        self.neighbor.isHidden = true
                    }))
                    MapViewController.presentAlert(ac2)
                }
            }))
            MapViewController.presentAlert(ac)
        } else {
            let ac = UIAlertController(title: "neighbor:", message: "neighbor_4".localized(), preferredStyle: .alert)
            ac.addAction(UIAlertAction.ok)
            MapViewController.presentAlert(ac)
        }
    }
    
    private func villager1Dialog() {
        let ac = UIAlertController(title: "villager:", message: "villager1_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func villager2Dialog() {
        let ac = UIAlertController(title: "villager:", message: "villager2_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func villager3Dialog() {
        let ac = UIAlertController(title: "villager:", message: "villager3_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func ratBattle() {
        MapViewController.instance?.presentWithFullScreen(storyboardId: "battleNC") { (nc: UINavigationController) in
            let battleVC = nc.topViewController as! BattleViewController
            battleVC.enemies = [Enemy("rat", type: .rat)]
            battleVC.processAfterBattle = { [unowned self] in
                EventTrigger.array[EventTrigger.killedRat] = 1
                self.setVisible()
            }
        }
    }
    
    private func pickupPotion() {
        Party.instance.gainItems([UsableItem.potionOfHealing])
        EventTrigger.array[EventTrigger.killedRat]  = 2
        potion.isHidden = true
        let ac = UIAlertController(title: "You picked up a potion.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func rest() {
        Party.instance.rest()
        let ac = UIAlertController(title: "Your characters are fully recovered.", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func persuade(target: Int) -> Bool {
        let liubei = Party.instance.pcs[0]
        let bonus = liubei.cha.modifier + liubei.proficiency
        return Int.random(in: 1...20) + bonus >= target
    }
    
    private func setVisible() {
        if EventTrigger.array[EventTrigger.neighborJoinYellowTurbans] == 1 {
            neighbor.isHidden = true
        } else {
            neighbor.isHidden = false
        }
        
        if EventTrigger.array[EventTrigger.killedRat] > 0 {
            rat.isHidden = true
        } else {
            rat.isHidden = false
        }
        
        if EventTrigger.array[EventTrigger.killedRat] != 1 {
            potion.isHidden = true
        } else {
            potion.isHidden = false
        }
    }
}
