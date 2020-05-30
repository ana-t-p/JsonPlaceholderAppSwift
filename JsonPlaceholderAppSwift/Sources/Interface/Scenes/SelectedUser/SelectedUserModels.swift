//
//  SelectedUserModels.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

struct PostsConfiguration {
    
    var bodies: [String]?
}

struct PhotoConfiguration {
    
    var photo: UIImage?
}

struct SelectedUser {
    
    struct UserInformation {
        
        struct Request {}
        struct Response {
            
            var selectedUser: ChoosenUser
        }
        struct ViewModel {
            
            var name: String
            var email: String
            var phone: String
        }
    }
    
    struct UserInformationError {
        
        struct Request {}
        struct Response {
            
            var error: String
        }
        struct ViewModel {
            
            var error: String
        }
    }
    
    struct UserDetails {
        
        struct Request {}
        struct Response {
            
            var photo: UIImage?
            var posts: [String]?
            var thereAreTodos: Bool
        }
        struct ViewModel {
            
            var photo: UIImage?
            var posts: [String]?
            var thereAreTodos: Bool
        }
    }
    
    struct UserDetailsError {
        
        struct Request {}
        struct Response {
            
            var error: String
        }
        struct ViewModel {
            
            var error: String
        }
    }
}
