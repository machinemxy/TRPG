//
//  MapViewController.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds
import SafariServices

class MapViewController: UIViewController {
    static var instance: MapViewController?
    
    @IBOutlet weak var btnParty: UIButton!
    @IBOutlet weak var btnData: UIButton!
    @IBOutlet weak var btnAbout: UIButton!
    
    var rewardedAd: GADRewardedAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Self.instance = self
        
        createAndLoadRewardedAd()
        
        btnParty.layer.borderWidth = 1
        btnParty.layer.borderColor = UIColor.link.cgColor
        btnData.layer.borderWidth = 1
        btnData.layer.borderColor = UIColor.link.cgColor
        btnAbout.layer.borderWidth = 1
        btnAbout.layer.borderColor = UIColor.link.cgColor
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Key.shopSegue {
            let navVC = segue.destination as! UINavigationController
            let shopVC = navVC.topViewController as! ShopViewController
            let itemIds = sender as! [Int]
            shopVC.itemids = itemIds
        }
    }
    
    @IBAction func unwindToMap(segue: UIStoryboardSegue) {
        // used by PartyTableView, ShopView, and when pcs win the battle
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
    
    @IBAction func aboutPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "About this app", message: "licenseBrief".localized(), preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Show Open Game License", style: .default, handler: { [unowned self] (_) in
            let safariVC = SFSafariViewController(url: URL(string: "https://media.wizards.com/2016/downloads/SRD-OGL_V1.1.pdf")!)
            self.present(safariVC, animated: true)
        }))
        
        ac.addAction(UIAlertAction.cancel)
        ac.popoverPresentationController?.sourceView = sender
        ac.popoverPresentationController?.sourceRect = sender.bounds
        present(ac, animated: true)
    }
}

extension MapViewController: GADRewardedAdDelegate {
    func createAndLoadRewardedAd() {
        rewardedAd = GADRewardedAd(adUnitID: Key.adKey)
        rewardedAd?.load(GADRequest()) { error in
        if let error = error {
            print("Loading failed: \(error)")
        } else {
            print("Loading Succeeded")
        }
      }
    }
    
    func rewardedAdDidDismiss(_ rewardedAd: GADRewardedAd) {
        self.alert(title: "Your characters are fully recovered.", message: nil)
        createAndLoadRewardedAd()
    }
    
    func watchAdAndRestForFree() -> Bool {
        if rewardedAd?.isReady == true {
            rewardedAd?.present(fromRootViewController: self, delegate:self)
            return true
        } else {
            return false
        }
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, userDidEarn reward: GADAdReward) {
        Party.instance.rest()
    }
    
    func rewardedAd(_ rewardedAd: GADRewardedAd, didFailToPresentWithError error: Error) {
        print("Rewarded ad failed to present.")
    }
}
