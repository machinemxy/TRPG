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
    override func didMove(to view: SKView) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "mother" {
                let ac = UIAlertController(title: "Liu Bei", message: "Mother, I'm going to town to sell grass shoes.", preferredStyle: .alert)
                ac.addAction(UIAlertAction.next {
                    let ac2 = UIAlertController(title: "Mother", message: "Take care of yourself, my son. Now the Yellow Turbans are everywhere.", preferredStyle: .alert)
                    ac2.addAction(UIAlertAction.ok)
                    MapViewController.presentAlert(ac2)
                })
                MapViewController.presentAlert(ac)
            }
        }
    }
}
