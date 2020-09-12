//
//  ShopViewController.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/12.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit
import SwiftUI

class ShopViewController: UIViewController {
    var itemids: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buy(_ sender: Any) {
        let shopBuyVC = UIHostingController(rootView: ShopBuyView(party: Party.instance, itemIds: itemids))
        navigationController?.pushViewController(shopBuyVC, animated: true)
    }
    
    @IBAction func sell(_ sender: Any) {
        
    }
}
