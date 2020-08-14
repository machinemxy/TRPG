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
    
    override func didMove(to view: SKView) {
        neighbor = childNode(withName: "neighbor")
        rat = childNode(withName: "rat")
        
        if EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] == 1 {
            neighbor.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "mother" {
                motherDialog()
            } else if node.name == "neighbor" {
                neighborDialog()
            } else if node.name == "old man" {
                oldManDialog()
            } else if node.name == "mid-aged man" {
                midAgedManDialog()
            } else if node.name == "young man" {
                youngManDialog()
            } else if node.name == "rest" {
                rest()
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
        if EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] == 0 {
            let ac = UIAlertController(title: "neighbor:", message: "neighbor_1".localized(), preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Let him go", style: .default, handler: { (_) in
                let ac2 = UIAlertController(title: "neighbor:", message: "neighbor_2".localized(), preferredStyle: .alert)
                ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                    EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] = 1
                    self.neighbor.isHidden = true
                }))
                MapViewController.presentAlert(ac2)
            }))
            ac.addAction(UIAlertAction(title: "Persuade him not go [difficulty 10]", style: .default, handler: { [unowned self] (_) in
                if self.persuade(target: 10) {
                    let ac2 = UIAlertController(title: "neighbor:", message: "neighbor_3".localized(), preferredStyle: .alert)
                    ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] = 2
                        Party.instance.gainExp(100)
                    }))
                    MapViewController.presentAlert(ac2)
                } else {
                    let ac2 = UIAlertController(title: "neighbor:", message: "neighbor_5".localized(), preferredStyle: .alert)
                    ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                        EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] = 1
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
    
    private func oldManDialog() {
        let ac = UIAlertController(title: "old man:", message: "oldMan_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func midAgedManDialog() {
        let ac = UIAlertController(title: "mid-aged man:", message: "midAgedMan_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        MapViewController.presentAlert(ac)
    }
    
    private func youngManDialog() {
        let ac = UIAlertController(title: "young man:", message: "youngMan_1".localized(), preferredStyle: .alert)
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
}
