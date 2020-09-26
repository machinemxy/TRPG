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
        guanYu = childNode(withName: "guanYu")
        zhangFei = childNode(withName: "zhangFei")
        panFeng = childNode(withName: "panFeng")
        wuAnguo = childNode(withName: "wuAnguo")
        joinGZ = childNode(withName: "joinGZ")
        joinPW = childNode(withName: "joinPW")
        
        setVisible()
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
    
    private func joinTable() {
        let ac = UIAlertController(title: "Warning", message: "This is a very import decition. You'd better observe the people in this table first. Are you sure to join this table?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
            // join
        }))
        ac.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        presentAlert(ac)
    }
    
    private func setVisible() {
        if EventTrigger.getValue(key: .metPartners) == 0 {
            joinGZ.isHidden = false
            joinPW.isHidden = false
        } else {
            joinGZ.isHidden = true
            joinPW.isHidden = true
        }
        
        if EventTrigger.getValue(key: .metPartners) == 1 {
            guanYu.isHidden = true
            zhangFei.isHidden = true
        } else {
            guanYu.isHidden = false
            zhangFei.isHidden = false
        }
        
        if EventTrigger.getValue(key: .metPartners) == 2 {
            panFeng.isHidden = true
            wuAnguo.isHidden = true
        } else {
            panFeng.isHidden = false
            wuAnguo.isHidden = false
        }
    }
}
