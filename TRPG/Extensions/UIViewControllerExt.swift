//
//  UIViewControllerExt.swift
//  TRPG
//
//  Created by Ma Xueyuan on 2020/08/09.
//  Copyright © 2020 Ma Xueyuan. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentWithFullScreen<T: UIViewController>(storyboardId: String, handler: ((T) -> Void)?){
        let vc = self.storyboard?.instantiateViewController(identifier: storyboardId) as! T
        if let wrappedHandler = handler {
            wrappedHandler(vc)
        }
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .coverVertical
        self.present(vc, animated: true)
    }
    
    func alert(title: String?, message: String?) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction.ok)
        present(ac, animated: true)
    }
}
