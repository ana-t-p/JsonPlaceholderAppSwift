//
//  SelectedUserInteractor.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol SelectedUserBusinessLogic {
    
    func doSetUserInformation(request: SelectedUser.UserInformation.Request)
    func doGetUserPhoto(request: SelectedUser.UserPhoto.Request)
    func doGetUserPosts(request: SelectedUser.UserPosts.Request)
}

protocol SelectedUserDataStore {
    
    var selectedUser: ChoosenUser? { get set }
}

class SelectedUserInteractor: SelectedUserBusinessLogic, SelectedUserDataStore {
    
    var presenter: SelectedUserPresentationLogic?
    var worker: SelectedUserWorker?
    var selectedUser: ChoosenUser?

    // MARK: Methods
    func doSetUserInformation(request: SelectedUser.UserInformation.Request) {
        
        if let selectedUser = selectedUser {
            
            let response = SelectedUser.UserInformation.Response(selectedUser: selectedUser)
            presenter?.presentUserInformation(response: response)
        } else {
            
            let response = SelectedUser.UserInformationError.Response(error: ErrorCases.userNotFound.localizedDescription)
            presenter?.presentUserInformationError(response: response)
        }
    }
    
    func doGetUserPhoto(request: SelectedUser.UserPhoto.Request) {
        
        if let selectedUser = selectedUser {
            
            worker = SelectedUserWorker()
            worker?.getAlbum(id: selectedUser.id, result: { [weak self] (id, error)  in
           
                if let id = id {
                    
                    self?.worker?.getPhoto(id: id, result: { (responseFromWorker) in
                        
                        switch responseFromWorker {
                            
                        case .success(data: let data):
                            
                            if let photo = data.photo {

                                let response = SelectedUser.UserPhoto.Response(photo: photo)
                                self?.presenter?.presentUserPhoto(response: response)
                            } else {
                                
                                let response = SelectedUser.UserPhotoError.Response(error: ErrorCases.apiCalling.localizedDescription)
                                self?.presenter?.presentUserPhotoError(response: response)
                            }
                        case .failure(error: let error):
                            let response = SelectedUser.UserPhotoError.Response(error: error.localizedDescription)
                            self?.presenter?.presentUserPhotoError(response: response)
                        }
                    })
                } else {
                    
                    let response = SelectedUser.UserPhotoError.Response(error: ErrorCases.apiCalling.localizedDescription)
                    self?.presenter?.presentUserPhotoError(response: response)
                }
            })
        } else {
            
            let response = SelectedUser.UserPhotoError.Response(error: ErrorCases.userNotFound.localizedDescription)
            presenter?.presentUserPhotoError(response: response)
        }
    }
    
    func doGetUserPosts(request: SelectedUser.UserPosts.Request) {
        
        if let selectedUser = selectedUser {
            
            worker = SelectedUserWorker()
            worker?.getPosts(id: selectedUser.id, result: { [weak self] (responseFromWorker) in
           
                switch responseFromWorker {
                    
                case .success(data: let data):
                    
                    if let bodies = data.bodies {

                        let response = SelectedUser.UserPosts.Response(posts: bodies)
                        self?.presenter?.presentUserPosts(response: response)
                    } else {
                        
                        let response = SelectedUser.UserPostsError.Response(error: ErrorCases.apiCalling.localizedDescription)
                        self?.presenter?.presentUserPostsError(response: response)
                    }
                case .failure(error: let error):
                    let response = SelectedUser.UserPostsError.Response(error: error.localizedDescription)
                    self?.presenter?.presentUserPostsError(response: response)
                }
            })
        } else {
            
            let response = SelectedUser.UserPostsError.Response(error: ErrorCases.userNotFound.localizedDescription)
            presenter?.presentUserPostsError(response: response)
        }
    }
}
