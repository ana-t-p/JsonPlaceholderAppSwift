//
//  SelectedUserInteractor.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol SelectedUserBusinessLogic {
    
    func doSomething(request: SelectedUser.Something.Request)
}

protocol SelectedUserDataStore {
    
    //var name: String { get set }
}

class SelectedUserInteractor: SelectedUserBusinessLogic, SelectedUserDataStore {
    
    var presenter: SelectedUserPresentationLogic?
    var worker: SelectedUserWorker?
    //var name: String = ""
    
    // MARK: Methods
    func doSomething(request: SelectedUser.Something.Request) {
        
        worker = SelectedUserWorker()
        worker?.doSomeWork()
        
        let response = SelectedUser.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
