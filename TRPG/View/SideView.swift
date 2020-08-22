//
//  SideView.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/15.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

class SideView: UIView {
    @IBOutlet var battlerViews: [BattlerView]!
    var battlers: [Battler]!
    
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
        
        view.frame = self.bounds

        self.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView? {
        let nib = UINib(nibName: "SideView", bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    func setBattlers(_ battlers: [Battler], isPc: Bool) {
        for i in 0...2 {
            if i >= battlers.count {
                battlerViews[i].setBattler(nil, isPc: false)
            } else {
                battlerViews[i].setBattler(battlers[i], isPc: isPc)
            }
        }
    }
}
