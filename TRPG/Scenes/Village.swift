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
    
    override func didMove(to view: SKView) {
        neighbor = childNode(withName: "neighbor")
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
            }
        }
    }
    
    private func motherDialog() {
        let ac = UIAlertController(title: "Liu Bei", message: "Mother, I'm going to town to sell grass shoes.", preferredStyle: .alert)
        ac.addAction(UIAlertAction.next {
            let ac2 = UIAlertController(title: "Mother", message: "Take care of yourself, my son. Now the Yellow Turbans are everywhere.", preferredStyle: .alert)
            ac2.addAction(UIAlertAction.ok)
            MapViewController.presentAlert(ac2)
        })
        MapViewController.presentAlert(ac)
    }
    
    private func neighborDialog() {
        if EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] == 0 {
            let ac = UIAlertController(title: "Neighbor", message: "I feel the Han Dynasty is reaching the end. Do you think it's advisable for me to join Yellow Turbans?", preferredStyle: .alert)
            ac.addAction(UIAlertAction.yes {
                let ac2 = UIAlertController(title: "Neighbor", message: "Really? I'll take your advice and join Yellow Turbans right now.", preferredStyle: .alert)
                ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                    EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] = 1
                    self.neighbor.isHidden = true
                }))
                MapViewController.presentAlert(ac2)
            })
            ac.addAction(UIAlertAction.no {
                let ac2 = UIAlertController(title: "Neighbor", message: "You are right. Yellow Turbans are not as justice as they declared.\n(You gain 100 exp)", preferredStyle: .alert)
                ac2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                    EventTrigger.array[EventTrigger.idNeighborJoinYellowTurbans] = 2
                    Party.instance.gainExp(100)
                }))
                MapViewController.presentAlert(ac2)
            })
            MapViewController.presentAlert(ac)
        } else {
            let ac = UIAlertController(title: "Neighbor", message: "You are right. Yellow Turbans are not as justice as they declared.", preferredStyle: .alert)
            ac.addAction(UIAlertAction.ok)
            MapViewController.presentAlert(ac)
        }
    }
}
