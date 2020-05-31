//
//  Constants.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright © 2020 Ana Tirado Pro. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    struct Urls {
        
        static let jsonPHUrl = "https://jsonplaceholder.typicode.com"
        static let users = "/users"
        static let posts = "/posts?userId="
        static let albums = "/albums?userId="
        static let photos = "/photos?albumId="
        static let todos = "/todos?userId="
    }
    
    struct Cells {
        
        static let collection = "postsCollectionViewCell"
        static let table = "todoListTableViewCell"
        static let estimatedRowHeight: CGFloat = 50.0
    }
}
