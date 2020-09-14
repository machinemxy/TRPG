//
//  Pub.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/14.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class Pub: SKScene {
    var guanYu: SKNode!
    var zhangFei: SKNode!
    var panFeng: SKNode!
    var wuAnguo: SKNode!
    var joinGZ: SKNode!
    var joinPW: SKNode!
    
    override func didMove(to view: SKView) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "exit" {
                switchScene(fileNamed: "Town")
                break
            } else if node.name == "pubKeeper" {
                pubKeeperDialog()
                break
            }
        }
    }
    
    private func pubKeeperDialog() {
        if EventTrigger.getValue(key: .metPartners) == 0 {
            let ac = UIAlertController(title: "pub keeper:", message: "pubKeeper_1".localized(), preferredStyle: .alert)
            ac.addAction(.ok)
            ac.addAction(UIAlertAction(title: "Trade", style: .default, handler: { [unowned self] (_) in
                self.showShop(itemIds: [UselessItem.yellowWine])
            }))
            presentAlert(ac)
        } else {
            showShop(itemIds: [UselessItem.yellowWine])
        }
    }
}
