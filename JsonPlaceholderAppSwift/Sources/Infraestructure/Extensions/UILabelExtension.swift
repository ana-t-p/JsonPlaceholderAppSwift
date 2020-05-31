//
//  UILabelExtension.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class LocalizableLabel: UILabel {
    
    @IBInspectable
    var localizedKey: String = "" {
        
        didSet {
            
            self.text = localizedKey.localized
        }
    }
}
