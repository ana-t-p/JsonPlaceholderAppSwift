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
    
    struct UserPosts {
        
        struct Request {}
        struct Response {
            
            var posts: [String]
        }
        struct ViewModel {
            
            var posts: [String]
        }
    }
    
    struct UserPostsError {
        
        struct Request {}
        struct Response {
            
            var error: String
        }
        struct ViewModel {
            
            var error: String
        }
    }
    
    struct UserPhoto {
        
        struct Request {}
        struct Response {
            
            var photo: UIImage?
        }
        struct ViewModel {
            
            var photo: UIImage?
        }
    }
    
    struct UserPhotoError {
        
        struct Request {}
        struct Response {
            
            var error: String
        }
        struct ViewModel {
            
            var error: String
        }
    }
}
