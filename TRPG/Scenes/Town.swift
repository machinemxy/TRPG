//
//  Town.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class Town: SKScene {
    override func didMove(to view: SKView) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "hotel" {
                hotelDialog()
                break
            }
        }
    }
    
    private func hotelDialog() {
        let ac = UIAlertController(title: "hotel keeper:", message: "hotel_keeper_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Standard(1G)", style: .default, handler: { [unowned self] (_) in
            if Party.instance.money >= 1 {
                Party.instance.money -= 1
                self.rest()
            } else {
                let ac2 = UIAlertController(title: "hotel keeper:", message: "hotel_keeper_2".localized(), preferredStyle: .alert)
                ac2.addAction(.ok)
                self.presentAlert(ac2)
            }
        }))
        ac.addAction(UIAlertAction(title: "Free(watch advertisement)", style: .default, handler: { [unowned self] (_) in
            if MapViewController.instance?.watchAdAndRestForFree() == false {
                let ac = UIAlertController(title: "Advertisement Load Failed", message: "Please try again or rest in standard room.", preferredStyle: .alert)
                ac.addAction(.ok)
                self.presentAlert(ac)
            }
        }))
        ac.addAction(.cancel)
        presentAlert(ac)
    }
}
