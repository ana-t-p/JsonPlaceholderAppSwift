//
//  HomeModels.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

struct UserConfiguration {
    
    let users: [ChoosenUser]?
}

struct Home {
    
    struct UsersResults {
        
        struct Request {}
        struct Response {
            
            var names: [String]
        }
        struct ViewModel {
            
            var names: [String]
        }
    }
    
    struct UsersResultsError {
        
        struct Request {}
        struct Response {
            
            var error: String
        }
        struct ViewModel {
            
            var error: String
        }
    }
    
    struct SelectedUserResults {
        
        struct Request {
            
            var id: Int
        }
        struct Response {}
        struct ViewModel {}
    }
    
    struct SelectedUserResultsError {
        
        struct Request {}
        struct Response {
            
            var error: String
        }
        struct ViewModel {
            
            var error: String
        }
    }
}
