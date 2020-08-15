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
    
    var battler: Battler!
    
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
    
    func setBattler(_ battler: Battler?) {
        if let battler = battler {
            lblName.text = battler.name
            barHp.setProgress(Float(battler.hp) / Float(battler.mhp), animated: false)
            lblHp.text = String(numerator: battler.hp, denominator: battler.mhp)
        } else {
            lblName.text = ""
            barHp.setProgress(0, animated: false)
            lblHp.text = ""
            btnAction.setTitle("-", for: .normal)
            btnAction.isEnabled = false
        }
    }
}
