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
}

protocol HomeDataStore {
    
    var user: ChoosenUser? { get set }
}

class HomeInteractor: HomeBusinessLogic, HomeDataStore {
    
    var presenter: HomePresentationLogic?
    var worker: HomeWorker?
    var user: ChoosenUser?
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
                    let response = Home.UserResults.Response(names: names)
                    self?.presenter?.presentGetUserList(response: response)
                } else {
                    
                    let response = Home.UserResultsError.Response(error: ErrorCases.apiCalling.localizedDescription)
                    self?.presenter?.presentGetUserListError(response: response)
                }
            case .failure(error: let error):
                let response = Home.UserResultsError.Response(error: error.localizedDescription)
                self?.presenter?.presentGetUserListError(response: response)
            }
        })
    }
}
