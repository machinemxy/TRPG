//
//  MapViewController.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit
import SpriteKit

class MapViewController: UIViewController {
    @IBOutlet weak var btnParty: UIButton!
    @IBOutlet weak var btnData: UIButton!
    
    static var instance: MapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Self.instance = self
        
        btnParty.layer.borderWidth = 1
        btnParty.layer.borderColor = UIColor.link.cgColor
        btnParty.backgroundColor = .secondarySystemBackground
        btnData.layer.borderWidth = 1
        btnData.layer.borderColor = UIColor.link.cgColor
        btnData.backgroundColor = .secondarySystemBackground
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: Party.instance.location) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        // used by PartyTableView, and when pcs win the battle
    }
    
    @IBAction func gameOver(segue: UIStoryboardSegue) {
        if let view = self.view as? SKView {
            if let scene = SKScene(fileNamed: Party.instance.location) {
                scene.scaleMode = .aspectFit
                view.presentScene(scene, transition: .flipVertical(withDuration: 0.5))
            }
        }
    }
    
    @IBAction func dataPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Save", style: .default, handler: { [unowned self] (_) in
            let success = DataManager.saveData()
            if success {
                self.alert(title: "Save finished", message: nil)
            } else {
                self.alert(title: "Save failed", message: "You can try again or clear this game without saving.")
            }
        }))
        
        ac.addAction(UIAlertAction(title: "Load", style: .default, handler: { [unowned self] (_) in
            let ac2 = UIAlertController(title: "Warning", message: "Your current progress will be lost. Are you sure?", preferredStyle: .alert)
            ac2.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (_) in
                DataManager.loadData()
                if let view = self.view as? SKView {
                    if let scene = SKScene(fileNamed: Party.instance.location) {
                        scene.scaleMode = .aspectFit
                        view.presentScene(scene, transition: .flipVertical(withDuration: 0.5))
                    }
                }
            }))
            ac2.addAction(UIAlertAction.cancel)
            self.present(ac2, animated: true)
        }))
        
        ac.addAction(UIAlertAction(title: "Restart From Beginning", style: .destructive, handler: { [unowned self] (_) in
            let ac2 = UIAlertController(title: "Warning", message: "Your current progress will be lost. Are you sure?", preferredStyle: .alert)
            ac2.addAction(UIAlertAction(title: "Yes", style: .default, handler: { [unowned self] (_) in
                DataManager.initData()
                if let view = self.view as? SKView {
                    if let scene = SKScene(fileNamed: Party.instance.location) {
                        scene.scaleMode = .aspectFit
                        view.presentScene(scene, transition: .flipVertical(withDuration: 0.5))
                    }
                }
            }))
            ac2.addAction(UIAlertAction.cancel)
            self.present(ac2, animated: true)
        }))
        
        ac.addAction(UIAlertAction.cancel)
        ac.popoverPresentationController?.sourceView = sender
        ac.popoverPresentationController?.sourceRect = sender.bounds
        present(ac, animated: true)
    }
    
    
    static func presentAlert(_ ac: UIAlertController) {
        instance?.present(ac, animated: true)
    }
}

