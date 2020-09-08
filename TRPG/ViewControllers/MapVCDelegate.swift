//
//  MapVCDelegate.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/09/08.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

protocol MapVCDelegate: class {
    func alert(ac: UIAlertController)
    
    var enemies: [Enemy] { get }
}
