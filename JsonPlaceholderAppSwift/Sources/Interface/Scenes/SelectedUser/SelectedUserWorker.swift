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
    
    func getSelectedUserDetails(_ id: Int, result: @escaping (_ userPhoto: PhotoConfiguration?, _ userPosts: PostsConfiguration?, _ userTodos: TodoListConfiguration?, _ errors: String) -> Void) {
        
        var userPhoto: PhotoConfiguration?
        var userPosts: PostsConfiguration?
        var userTodos: TodoListConfiguration?
        var errors = [String]()
        var errorDetails = ""
        let group = DispatchGroup()
        
        group.enter()
        getAlbum(id: id) { (photo, error) in
            
            if let photo = photo {
                
                userPhoto = photo
            } else if let error = error {
                
                errors.append("\("error.type.photo".localized)\(error.localizedDescription)")
            }
            group.leave()
        }
        group.enter()
        getPosts(id: id) { (response) in
            
            switch response {
                
            case .success(data: let data):
                userPosts = PostsConfiguration(bodies: data.bodies)
            case .failure(error: let error):
                errors.append("\("error.type.posts".localized)\(error.localizedDescription)")
            }
            group.leave()
        }
        group.enter()
        getTodoList(id: id) { (response) in
            
            switch response {
                
            case .success(data: let data):
                userTodos = TodoListConfiguration(todoList: data.todoList)
            case .failure(error: let error):
                errors.append("\("error.type.todolist".localized)\(error.localizedDescription)")
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            
            errorDetails = errors.joined(separator: "\n")
            result(userPhoto, userPosts, userTodos, errorDetails)
        }
    }
    
    // MARK: Private methods
    private func getAlbum(id: Int, result: @escaping (_ photo: PhotoConfiguration?, _ error: Error?) -> Void) {
                
        JSONPlaceholderAPI.getUserFirstAlbum(id) { [weak self] (albumResponseData, error) in
            
            if let error = error {
                
                result(nil, error)
            } else if let albumResponseData = albumResponseData {
    
                self?.getPhoto(id: albumResponseData.id) { (response) in
                    
                    switch response {
                        
                    case .success(data: let data):
                        result(PhotoConfiguration(photo: data.photo), nil)
                    case .failure(error: let error):
                        result(nil, error)
                    }
                }
            }
        }
    }
    
    private func getPhoto(id: Int, result: @escaping SelectedUserWorkerCompletionHandler2) {
                
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
    
    private func getPosts(id: Int, result: @escaping SelectedUserWorkerCompletionHandler) {
                
        JSONPlaceholderAPI.getUserPosts(id) { (postResponseData, error) in
            
            if let error = error {
                
                result(JSONPlaceholderAPIPostsResult.failure(error: error))
            } else if let postResponseData = postResponseData {
                
                let bodies = postResponseData.map({ $0.body })
                result(JSONPlaceholderAPIPostsResult.success(data: PostsConfiguration(bodies: bodies)))
            }
        }
    }
    
    private func getTodoList(id: Int, result: @escaping TodoListWorkerCompletionHandler) {
                
        JSONPlaceholderAPI.getUserTODOList(id) { (todoListResponseData, error) in
            
            if let error = error {
                
                result(JSONPlaceholderAPITodoListResult.failure(error: error))
            } else if let todoListResponseData = todoListResponseData {
    
                var todoList = [SingleTodo]()
                for todo in todoListResponseData {
                    
                    todoList.append(SingleTodo(done: todo.completed, text: todo.title))
                }
                result(JSONPlaceholderAPITodoListResult.success(data: TodoListConfiguration(todoList: todoList)))
            }
        }
    }
}
