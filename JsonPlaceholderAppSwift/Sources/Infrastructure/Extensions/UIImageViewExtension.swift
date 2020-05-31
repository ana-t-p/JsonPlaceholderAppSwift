//
//  UIImageViewExtension.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    func load(url: URL, result: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        DispatchQueue.global().async {
            
            if let data = try? Data(contentsOf: url) {
                
                ui {
                    if let image = UIImage(data: data) {
                        
                        result(image, nil)
                    } else {
                        
                        result(nil, ErrorCases.usedURL)
                    }
                }
            } else {
                
                result(nil, ErrorCases.usedURL)
            }
        }
    }
}
