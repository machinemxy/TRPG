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
    static var instance: MapViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Self.instance = self
        
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
        ac.addAction(UIAlertAction(title: "Load", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "Restart From Beginning", style: .destructive, handler: nil))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.popoverPresentationController?.sourceView = sender
        ac.popoverPresentationController?.sourceRect = sender.bounds
        present(ac, animated: true)
    }
    
    
    static func presentAlert(_ ac: UIAlertController) {
        instance?.present(ac, animated: true)
    }
}

