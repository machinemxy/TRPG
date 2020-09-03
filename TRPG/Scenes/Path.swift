//
//  Path.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/30.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit

class Path: SKScene {
    var villageEntrance: SKNode!
    var castleEntrance: SKNode!
    
    override func didMove(to view: SKView) {
        villageEntrance = SKNode(fileNamed: "villageEntrance")
        castleEntrance = SKNode(fileNamed: "castleEntrance")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        for node in nodes(at: touchPoint) {
            if node.name == "villageEntrance" {
                switchScene(fileNamed: "Village")
            }
        }
    }
}
