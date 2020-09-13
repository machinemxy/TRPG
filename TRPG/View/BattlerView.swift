//
//  BattlerView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

class BattlerView: UIView {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var barHp: UIProgressView!
    @IBOutlet weak var lblHp: UILabel!
    @IBOutlet weak var btnAction: UIButton!
    
    weak var mapVCDelegate: MapVCDelegate?
    var battler: Battler?
    var target: Battler?
    var action = Action.noAction
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        view.frame = self.bounds

        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "BattlerView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setBattler(_ battler: Battler?, isPc: Bool) {
        if let battler = battler {
            self.battler = battler
            lblName.text = battler.name
            barHp.setProgress(Float(battler.hp) / Float(battler.mhp), animated: false)
            lblHp.text = String(numerator: battler.hp, denominator: battler.mhp)
            action = battler.defaultAction
            if !isPc {
                lblName.textColor = .systemRed
                btnAction.isEnabled = false
            }
        } else {
            // no battler in this view
            lblName.text = ""
            barHp.setProgress(0, animated: false)
            lblHp.text = ""
            btnAction.isEnabled = false
        }
        
        updateBtnActionTitle()
    }
    
    func updateHP() {
        if let battler = battler {
            barHp.setProgress(Float(battler.hp) / Float(battler.mhp), animated: true)
            lblHp.text = String(numerator: battler.hp, denominator: battler.mhp)
        }
    }
    
    func updateBtnActionTitle() {
        btnAction.setTitle(action.description(target: target), for: .normal)
    }
    
    @IBAction func changeAction(_ sender: UIButton) {
        let ac = UIAlertController(title: "Change Action", message: nil, preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(title: "Attack", style: .default, handler: { [unowned self] (_) in
            let ac2 = UIAlertController(title: "Select Target", message: nil, preferredStyle: .actionSheet)
            
            ac2.addAction(UIAlertAction(title: "Random", style: .destructive, handler: { [unowned self] (_) in
                self.action = .attack
                self.target = nil
                self.updateBtnActionTitle()
            }))
            
            if let enemies = self.mapVCDelegate?.enemies {
                for enemy in enemies.filter({ $0.isAlive }) {
                    ac2.addAction(UIAlertAction(title: enemy.name, style: .default, handler: { [unowned self] (_) in
                        self.action = .attack
                        self.target = enemy
                        self.updateBtnActionTitle()
                    }))
                }
            }
            
            ac2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac2.popoverPresentationController?.sourceView = sender
            ac2.popoverPresentationController?.sourceRect = sender.bounds
            self.mapVCDelegate?.alert(ac: ac2)
        }))
        
        ac.addAction(UIAlertAction(title: "Item", style: .default, handler: { [unowned self](_) in
            let ac2 = UIAlertController(title: "Select Item", message: nil, preferredStyle: .actionSheet)
            
            for itemId in Party.instance.usableItemIds {
                let item = itemId.toUsableItem()
                let count = Party.instance.inventories[itemId]!
                ac2.addAction(UIAlertAction(title: "\(item.name)(\(count))", style: .default, handler: { [unowned self] (_) in
                    self.action = item.useAction
                    self.target = nil
                    self.updateBtnActionTitle()
                }))
            }
            
            ac2.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            ac2.popoverPresentationController?.sourceView = sender
            ac2.popoverPresentationController?.sourceRect = sender.bounds
            self.mapVCDelegate?.alert(ac: ac2)
        }))
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.popoverPresentationController?.sourceView = sender
        ac.popoverPresentationController?.sourceRect = sender.bounds
        mapVCDelegate?.alert(ac: ac)
    }
    
}
