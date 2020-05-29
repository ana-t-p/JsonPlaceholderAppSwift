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
        
        let destinationVC = SelectedUserViewController()
        guard var destinationDS = destinationVC.router?.dataStore,
              let dataStore = dataStore,
              let viewController = viewController else { return }

        passDataToSelectedUser(source: dataStore, destination: &destinationDS)
        navigateToSelectedUser(source: viewController, destination: destinationVC)
    }
    
    // MARK: Navigation
    func navigateToSelectedUser(source: HomeViewController, destination: SelectedUserViewController) {
        
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    func passDataToSelectedUser(source: HomeDataStore, destination: inout SelectedUserDataStore) {
        
        //    destination.name = source.name
    }
}
