//
//  HomePresenter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 28/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol HomePresentationLogic {
    
    func presentGetUserList(response: Home.UsersResults.Response)
    func presentGetUserListError(response: Home.UsersResultsError.Response)
    func presentSelectedUserDetail(response: Home.SelectedUserResults.Response)
    func presentSelectedUserDetailError(response: Home.SelectedUserResultsError.Response)
}

class HomePresenter: HomePresentationLogic {

    weak var viewController: HomeDisplayLogic?
    
    // MARK: Methods
    func presentGetUserList(response: Home.UsersResults.Response) {
        
        let viewModel = Home.UsersResults.ViewModel(names: response.names)
        viewController?.displayGetUserList(viewModel: viewModel)
    }
    
    func presentGetUserListError(response: Home.UsersResultsError.Response) {
        
        let viewModel = Home.UsersResultsError.ViewModel(error: response.error)
        viewController?.displayGetUserListError(viewModel: viewModel)
    }
    
    func presentSelectedUserDetail(response: Home.SelectedUserResults.Response) {
        
        let viewModel = Home.SelectedUserResults.ViewModel()
        viewController?.displaySelectedUser(viewModel: viewModel)
    }
    
    func presentSelectedUserDetailError(response: Home.SelectedUserResultsError.Response) {
        
        let viewModel = Home.SelectedUserResultsError.ViewModel(error: response.error)
        viewController?.displaySelectedUserError(viewModel: viewModel)
    }
}
