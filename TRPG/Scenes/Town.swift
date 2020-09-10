//
//  Town.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class Town: SKScene {
    var sellShoes: SKNode!
    
    override func didMove(to view: SKView) {
        sellShoes = childNode(withName: "sellShoes")
        
        setVisible()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "hotel" {
                hotelDialog()
                break
            } else if node.name == "exit" {
                switchScene(fileNamed: "Path")
                break
            } else if node.name == "sellShoes" {
                sellShoesDialog()
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
    
    private func sellShoesDialog() {
        let shoesCount = Party.instance.inventories[UselessItem.grassShoes] ?? 0
        let money = 0.1 * Double(shoesCount)
        let ac = UIAlertController(title: "Sell Result", message: "You sold \(shoesCount) grass shoes and got \(money)G.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
            Party.instance.inventories.removeValue(forKey: UselessItem.grassShoes)
            Party.instance.money += money
            EventTrigger.setValue(key: .shoesSold, value: 1)
            self.sellShoes.isHidden = true
        }))
        presentAlert(ac)
        
    }
    
    private func setVisible() {
        if EventTrigger.getValue(key: .shoesSold) == 0 {
            sellShoes.isHidden = false
        } else {
            sellShoes.isHidden = true
        }
    }
}
