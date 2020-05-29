//
//  Utils.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation

func ui(_ f: @escaping () -> Void) {
    
    DispatchQueue.main.async {
        
        f()
    }
}
