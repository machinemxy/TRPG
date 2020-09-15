//
//  Title.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class Title: SKScene {
    var clouds = [SKNode]()
    var press: SKNode!
    
    override func didMove(to view: SKView) {
        clouds.append(childNode(withName: "cloud1")!)
        clouds.append(childNode(withName: "cloud2")!)
        clouds.append(childNode(withName: "cloud3")!)
        press = childNode(withName: "press")!
        
        let sequece = SKAction.sequence([
            SKAction.fadeOut(withDuration: 0.5),
            SKAction.fadeIn(withDuration: 0.5)
        ])
        let repead = SKAction.repeatForever(sequece)
        press.run(repead)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let _ = touches.first else { return }
        
        press.removeAllActions()
        switchScene(fileNamed: Party.instance.location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for cloud in clouds {
            cloud.position.x -= 1
            if cloud.position.x < -484 {
                cloud.position.x = 484
            }
        }
    }
}
