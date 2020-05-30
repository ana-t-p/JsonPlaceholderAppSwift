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
    func doGetUserDetails(request: SelectedUser.UserDetails.Request)
}

protocol SelectedUserDataStore {
    
    var selectedUser: ChoosenUser? { get set }
    var todoList: [SingleTodo]? { get set }
}

class SelectedUserInteractor: SelectedUserBusinessLogic, SelectedUserDataStore {

    var presenter: SelectedUserPresentationLogic?
    var worker: SelectedUserWorker?
    var selectedUser: ChoosenUser?
    var todoList: [SingleTodo]?

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
    
    func doGetUserDetails(request: SelectedUser.UserDetails.Request) {
        
        if let selectedUser = selectedUser {

            worker = SelectedUserWorker()
            worker?.getSelectedUserDetails(selectedUser.id, result: { [weak self] (photo, posts, todoList, errorDetails) in
                
                let response = SelectedUser.UserDetails.Response(photo: photo?.photo, posts: posts?.bodies)
                self?.presenter?.presentUserDetails(response: response)
                
                if !errorDetails.isEmpty {
                    
                    let responseError = SelectedUser.UserDetailsError.Response(error: errorDetails)
                    self?.presenter?.presentUserDetailsError(response: responseError)
                }
            })
        }
    }
}
