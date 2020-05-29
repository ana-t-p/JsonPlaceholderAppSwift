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
    
    class func showErrorPopup(_ text: String, vc: UIViewController) {
        
        let alert = UIAlertController(title: "error.title".localized, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "error.button".localized, style: .cancel, handler: nil))

        ui {
            
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
