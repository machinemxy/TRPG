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
            } else if node.name == "guanYu" {
                let ac = UIAlertController(title: "Observation", message: "observation_guanYu".localized(), preferredStyle: .alert)
                ac.addAction(.ok)
                presentAlert(ac)
                break
            } else if node.name == "zhangFei" {
                let ac = UIAlertController(title: "Observation", message: "observation_zhangFei".localized(), preferredStyle: .alert)
                ac.addAction(.ok)
                presentAlert(ac)
                break
            } else if node.name == "panFeng" {
                let ac = UIAlertController(title: "Observation", message: "observation_panFeng".localized(), preferredStyle: .alert)
                ac.addAction(.ok)
                presentAlert(ac)
                break
            } else if node.name == "wuAnguo" {
                let ac = UIAlertController(title: "Observation", message: "observation_wuAnguo".localized(), preferredStyle: .alert)
                ac.addAction(.ok)
                presentAlert(ac)
                break
            } else if node.name == "joinGZ" {
                joinTable(isHardMode: false)
                break
            } else if node.name == "joinPW" {
                joinTable(isHardMode: true)
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
    
    private func joinTable(isHardMode: Bool) {
        let ac = UIAlertController(title: "Warning", message: "joinTable_1".localized(), preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (_) in
            let ac2 = UIAlertController(title: "Info", message: "joinTable_2".localized(), preferredStyle: .alert)
            ac2.addAction(.next { [unowned self] in
                let ac3 = UIAlertController(title: "Info", message: "joinTable_3".localized(), preferredStyle: .alert)
                ac3.addAction(UIAlertAction(title: "OK", style: .default, handler: { [unowned self] (_) in
                    Party.instance.gainItems([UselessItem.gardenKey])
                    if isHardMode {
                        EventTrigger.setValue(key: .metPartners, value: 2)
                        Party.instance.pcs.append(Fighter.initPanFeng())
                        Party.instance.pcs.append(Barbarian.initWuAnguo())
                    } else {
                        EventTrigger.setValue(key: .metPartners, value: 1)
                        Party.instance.pcs.append(Fighter.initGuanYu())
                        Party.instance.pcs.append(Barbarian.initZhangFei())
                    }
                    setVisible()
                }))
                presentAlert(ac3)
            })
            presentAlert(ac2)
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
