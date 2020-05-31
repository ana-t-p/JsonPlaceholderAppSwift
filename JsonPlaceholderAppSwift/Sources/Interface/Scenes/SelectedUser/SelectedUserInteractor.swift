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
    var name: String? { get set }
    var todoList: [SingleTodo]? { get set }
}

class SelectedUserInteractor: SelectedUserBusinessLogic, SelectedUserDataStore {

    var presenter: SelectedUserPresentationLogic?
    var worker: SelectedUserWorker? = SelectedUserWorker()
    var selectedUser: ChoosenUser?
    var name: String?
    var todoList: [SingleTodo]?

    // MARK: Methods
    func doSetUserInformation(request: SelectedUser.UserInformation.Request) {
        
        if let selectedUser = selectedUser {
            
            name = selectedUser.surname
            let response = SelectedUser.UserInformation.Response(selectedUser: selectedUser)
            presenter?.presentUserInformation(response: response)
        } else {
            
            let response = SelectedUser.UserInformationError.Response(error: ErrorCases.userNotFound.localizedDescription)
            presenter?.presentUserInformationError(response: response)
        }
    }
    
    func doGetUserDetails(request: SelectedUser.UserDetails.Request) {
        
        if let selectedUser = selectedUser {

            worker?.getSelectedUserDetails(selectedUser.id, result: { [weak self] (photo, posts, todoList, errorDetails) in
                
                self?.todoList = todoList?.todoList
                let response = SelectedUser.UserDetails.Response(photo: photo?.photo, posts: posts?.bodies, thereAreTodos: todoList?.todoList?.isEmpty == false ? true : false)
                self?.presenter?.presentUserDetails(response: response)
                
                if !errorDetails.isEmpty {
                    
                    let responseError = SelectedUser.UserDetailsError.Response(error: errorDetails)
                    self?.presenter?.presentUserDetailsError(response: responseError)
                }
            })
        }
    }
}
