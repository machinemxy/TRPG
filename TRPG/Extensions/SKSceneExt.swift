//
//  SKSceneExt.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/02.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import SpriteKit

extension SKScene {
    func switchScene(fileNamed fileName: String) {
        if let scene = SKScene(fileNamed: fileName) {
            Party.instance.location = fileName
            scene.scaleMode = .aspectFit
            view?.presentScene(scene, transition: .flipVertical(withDuration: 0.5))
        }
    }
}
