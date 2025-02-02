//
//  HomeRouter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

@objc protocol HomeRoutingLogic {
    
    func routeToSelectedUser()
}

protocol HomeDataPassing {
    
    var dataStore: HomeDataStore? { get }
}

class HomeRouter: NSObject, HomeRoutingLogic, HomeDataPassing {
    
    weak var viewController: HomeViewController?
    var dataStore: HomeDataStore?
    
    // MARK: Routing
    func routeToSelectedUser() {
        
        
        let storyboard = UIStoryboard(name: "SelectedUser", bundle: nil)
        guard let destinationVC = storyboard.instantiateViewController(withIdentifier: "SelectedUserViewController") as? SelectedUserViewController,
              var destinationDS = destinationVC.router?.dataStore,
              let dataStore = dataStore,
              let navigationController = viewController?.navigationController else { return }

        passDataToSelectedUser(source: dataStore, destination: &destinationDS)
        navigateToSelectedUser(source: navigationController, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToSelectedUser(source: UINavigationController, destination: SelectedUserViewController) {
        
        source.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    func passDataToSelectedUser(source: HomeDataStore, destination: inout SelectedUserDataStore) {
        
        destination.selectedUser = source.selectedUser
    }
}
