//
//  TodoListRouter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

@objc protocol TodoListRoutingLogic {
    
    func routeToSelectedUser()
}

protocol TodoListDataPassing {
    
    var dataStore: TodoListDataStore? { get }
}

class TodoListRouter: NSObject, TodoListRoutingLogic, TodoListDataPassing {
    
    weak var viewController: TodoListViewController?
    var dataStore: TodoListDataStore?
    
    // MARK: Routing
    func routeToSelectedUser() {
        
        ui { [weak self] in
            self?.viewController?.dismiss(animated: true)
        }
    }
}
