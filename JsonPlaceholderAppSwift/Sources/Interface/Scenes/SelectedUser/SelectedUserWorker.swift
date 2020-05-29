//
//  SelectedUserWorker.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

enum JSONPlaceholderAPIPostsResult {
    
    case success(data: PostsConfiguration)
    case failure(error: Error)
}

typealias SelectedUserWorkerCompletionHandler = (_ data: JSONPlaceholderAPIPostsResult) -> Void

class SelectedUserWorker {
    
    func getPosts(id: Int, result: @escaping SelectedUserWorkerCompletionHandler) {
                
        JSONPlaceholderAPI.getUserPosts(id) { (postResponseData, error) in
            
            if let error = error {
                
                result(JSONPlaceholderAPIPostsResult.failure(error: error))
            } else if let postResponseData = postResponseData {
                
                let bodies = postResponseData.map({ $0.body })
                result(JSONPlaceholderAPIPostsResult.success(data: PostsConfiguration(bodies: bodies)))
            }
        }
    }
}
