//
//  HomeInteractor.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol HomeBusinessLogic {
    
    func doGetUserList()
    func doGoToSelectedUser(request: Home.SelectedUserResults.Request)
}

protocol HomeDataStore {
    
    var selectedUser: ChoosenUser? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    var selectedUser: ChoosenUser?
    var users: [ChoosenUser]?

    // MARK: Methods
    func doGetUserList() {
        
        worker = HomeWorker()
        worker?.getUserList(result: { [weak self] (responseFromWorker) in
            
            switch responseFromWorker {
                
            case .success(data: let data):
                
                if let users = data.users {
                    
                    self?.users = users
                    var names = [String]()
                    for user in users {
                        
                        names.append(user.surname)
                    }
                    let response = Home.UsersResults.Response(names: names)
                    self?.presenter?.presentGetUserList(response: response)
                } else {
                    
                    let response = Home.UsersResultsError.Response(error: ErrorCases.apiCalling.localizedDescription)
                    self?.presenter?.presentGetUserListError(response: response)
                }
            case .failure(error: let error):
                let response = Home.UsersResultsError.Response(error: error.localizedDescription)
                self?.presenter?.presentGetUserListError(response: response)
            }
        })
    }
    
    func doGoToSelectedUser(request: Home.SelectedUserResults.Request) {
        
        if let users = users {
            
            selectedUser = users[request.id - 1]
            let response = Home.SelectedUserResults.Response()
            presenter?.presentSelectedUserDetail(response: response)
        } else {
            
            let response = Home.SelectedUserResultsError.Response(error: ErrorCases.userNotFound.localizedDescription)
            presenter?.presentSelectedUserDetailError(response: response)
        }
        
    }
}
