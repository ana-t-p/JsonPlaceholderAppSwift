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
}
