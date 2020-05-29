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

enum JSONPlaceholderAPIPhotoResult {
    
    case success(data: PhotoConfiguration)
    case failure(error: Error)
}

typealias SelectedUserWorkerCompletionHandler2 = (_ data: JSONPlaceholderAPIPhotoResult) -> Void


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
    
    func getAlbum(id: Int, result: @escaping (_ id: Int?, _ error: Error?) -> Void) {
                
        JSONPlaceholderAPI.getUserFirstAlbum(id) { (albumResponseData, error) in
            
            if let error = error {
                
                result(nil, error)
            } else if let albumResponseData = albumResponseData {
    
                result(albumResponseData.id, nil)
            }
        }
    }
    
    func getPhoto(id: Int, result: @escaping SelectedUserWorkerCompletionHandler2) {
                
        JSONPlaceholderAPI.getUserPhoto(id) { (photoResponseData, error) in
            
            if let error = error {
                
                result(JSONPlaceholderAPIPhotoResult.failure(error: error))
            } else if let photoResponseData = photoResponseData, let url = URL(string: photoResponseData.url) {
    
                UIImage().load(url: url) { (receivedImage, error) in
                    
                    if let receivedImage = receivedImage {
                        
                        result(JSONPlaceholderAPIPhotoResult.success(data: PhotoConfiguration(photo: receivedImage)))
                    } else if let error = error {
                        
                        result(JSONPlaceholderAPIPhotoResult.failure(error: error))
                    }
                }
            }
        }
    }
}
