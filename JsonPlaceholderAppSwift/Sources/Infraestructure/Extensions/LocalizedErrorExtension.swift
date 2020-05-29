//
//  LocalizedErrorExtension.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation


enum ErrorCases: Error {
    
    case usedURL
    case apiCalling
    case decoding
    case userNotFound
}

extension ErrorCases: LocalizedError {
    
    var errorDescription: String? {
        
        switch self {
            
        case .usedURL:
            return "error.usedURL".localized
        case .apiCalling:
            return "error.apiCalling".localized
        case .decoding:
            return "error.decoding".localized
        case .userNotFound:
            return "error.userNotFound".localized
        }
    }
}
