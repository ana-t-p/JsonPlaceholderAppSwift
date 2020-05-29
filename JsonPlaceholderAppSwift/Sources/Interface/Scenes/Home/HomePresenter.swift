//
//  HomePresenter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    
    func presentGetUserList(response: Home.UserResults.Response)
    func presentGetUserListError(response: Home.UserResultsError.Response)
}

class HomePresenter: HomePresentationLogic {
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: Methods
    func presentGetUserList(response: Home.UserResults.Response) {
        
        let viewModel = Home.UserResults.ViewModel(names: response.names)
        viewController?.displayGetUserList(viewModel: viewModel)
    }
    
    func presentGetUserListError(response: Home.UserResultsError.Response) {
        
        let viewModel = Home.UserResultsError.ViewModel(error: response.error)
        viewController?.displayGetUserListError(viewModel: viewModel)
    }
}
