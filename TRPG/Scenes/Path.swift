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
    var pcLocation: SKNode!
    var move1: SKNode!
    var move2: SKNode!
    var move3: SKNode!
    var move4: SKNode!
    var moveShortCut: SKNode!
    
    override func didMove(to view: SKView) {
        villageEntrance = childNode(withName: "villageEntrance")
        castleEntrance = childNode(withName: "castleEntrance")
        pcLocation = childNode(withName: "pcLocation")
        move1 = childNode(withName: "move1")
        move2 = childNode(withName: "move2")
        move3 = childNode(withName: "move3")
        move4 = childNode(withName: "move4")
        moveShortCut = childNode(withName: "moveShortCut")
        
        if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
            pcLocation.position = villageEntrance.position
        } else {
            pcLocation.position = castleEntrance.position
        }
        
        setVisible()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchPoint = touch.location(in: self)
        let eventNodes = nodes(at: touchPoint).filter {
            let n = $0.name
            return n == "villageEntrance" || n == "castleEntrance" || n == "move1" || n == "move2" ||
            n == "move3" || n == "move4" || n == "moveShortCut"
        }
        
        if let node = eventNodes.first {
            isUserInteractionEnabled = false
            pcLocation.run(SKAction.move(to: node.position, duration: 0.5)) { [unowned self] in
                self.isUserInteractionEnabled = true
                if node.name == "villageEntrance" {
                    EventTrigger.setValue(key: .fromVillageToTown, value: 0)
                    self.switchScene(fileNamed: "Village")
                } else if node.name == "move1" {
                    self.move1Action()
                } else if node.name == "move2" {
                    self.move2Action()
                } else if node.name == "move3" {
                    self.move3Action()
                } else if node.name == "move4" {
                    self.move4Action()
                } else if node.name == "moveShortCut" {
                    self.moveShortCutAction()
                } else if node.name == "castleEntrance" {
                    EventTrigger.setValue(key: .fromVillageToTown, value: 1)
                    self.switchScene(fileNamed: "Town")
                }
            }
        }
    }
    
    private func move1Action() {
        let enemies = getEnemiesOnMainPath()
        startBattle(enemies: enemies) { [unowned self] in
            if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
                self.move2.isHidden = false
                self.moveShortCut.isHidden = false
            } else {
                self.villageEntrance.isHidden = false
            }
        }
    }
    
    private func move2Action() {
        let enemies = getEnemiesOnMainPath()
        startBattle(enemies: enemies) { [unowned self] in
            if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
                self.move3.isHidden = false
            } else {
                self.move1.isHidden = false
            }
        }
    }
    
    private func move3Action() {
        let enemies = getEnemiesOnMainPath()
        startBattle(enemies: enemies) { [unowned self] in
            if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
                self.move4.isHidden = false
            } else {
                self.move2.isHidden = false
            }
        }
    }
    
    private func move4Action() {
        let enemies = getEnemiesOnMainPath()
        startBattle(enemies: enemies) { [unowned self] in
            if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
                self.castleEntrance.isHidden = false
            } else {
                self.move3.isHidden = false
                self.moveShortCut.isHidden = false
            }
        }
    }
    
    private func moveShortCutAction() {
        let enemies = [Enemy("snake", type: .snake)]
        startBattle(enemies: enemies) { [unowned self] in
            if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
                self.move4.isHidden = false
            } else {
                self.move1.isHidden = false
            }
        }
    }
    
    private func getEnemiesOnMainPath() -> [Enemy] {
        let dice = Int.random(in: 0...2)

        if dice == 0 {
            return [Enemy("rat", type: .rat)]
        } else if dice == 1 {
            return [Enemy("rat1", type: .rat), Enemy("rat2", type: .rat)]
        } else {
            return [Enemy("YT recruit", type: .YTRecruit)]
        }
    }
    
    private func setVisible() {
        villageEntrance.isHidden = true
        castleEntrance.isHidden = true
        move1.isHidden = true
        move2.isHidden = true
        move3.isHidden = true
        move4.isHidden = true
        moveShortCut.isHidden = true
        
        if EventTrigger.getValue(key: .fromVillageToTown) == 0 {
            villageEntrance.isHidden = false
            move1.isHidden = false
        } else {
            castleEntrance.isHidden = false
            move4.isHidden = false
        }
    }
}
