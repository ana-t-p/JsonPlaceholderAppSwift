//
//  SelectedUserRouter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

@objc protocol SelectedUserRoutingLogic {
    
    func routeToUserTodoList()
}

protocol SelectedUserDataPassing {
    
    var dataStore: SelectedUserDataStore? { get }
}

class SelectedUserRouter: NSObject, SelectedUserRoutingLogic, SelectedUserDataPassing {
    
    weak var viewController: SelectedUserViewController?
    var dataStore: SelectedUserDataStore?
    
    // MARK: Routing
    func routeToUserTodoList() {
        
        let storyboard = UIStoryboard(name: "TodoList", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as? TodoListViewController,
              var destinationDS = destinationVC.router?.dataStore,
              let dataStore = dataStore,
              let viewController = viewController else { return }
        
        passDataToUserTodoList(source: dataStore, destination: &destinationDS)
        navigateToUserTodoList(source: viewController, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToUserTodoList(source: SelectedUserViewController, destination: TodoListViewController) {
        
        destination.modalPresentationStyle = .overFullScreen
        source.present(destination, animated: true, completion: nil)
    }
    
    // MARK: Passing data
    func passDataToUserTodoList(source: SelectedUserDataStore, destination: inout TodoListDataStore) {
        
        destination.name = source.name
        destination.todoList = source.todoList
    }
}
