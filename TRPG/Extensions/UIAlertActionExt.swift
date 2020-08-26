//
//  UIAlertActionExt.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

extension UIAlertAction {
    static let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    static let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    
    static func next(handler: @escaping () -> Void) -> UIAlertAction {
        return UIAlertAction(title: "Next", style: .default) { (_) in
            handler()
        }
    }
}
