//
//  StringExtension.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
}
