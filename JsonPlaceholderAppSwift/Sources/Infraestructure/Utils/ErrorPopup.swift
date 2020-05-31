//
//  ErrorPopup.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation
import UIKit

class ErrorPopup {
    
    class func showErrorPopup(_ text: String, vc: UIViewController, tryAgain: Bool = false, completionHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: "popuperror.title".localized, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "popuperror.button.ok".localized, style: .cancel, handler: nil))
        
        if tryAgain {
            
            alert.addAction(UIAlertAction(title: "popuperror.button.tryagain".localized, style: .default, handler: { (_) in
                
                completionHandler?()
            }))
        }

        ui {
            
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
