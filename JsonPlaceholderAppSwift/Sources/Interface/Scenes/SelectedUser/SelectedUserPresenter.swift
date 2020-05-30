//
//  SelectedUserPresenter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol SelectedUserPresentationLogic {
    
    func presentUserInformation(response: SelectedUser.UserInformation.Response)
    func presentUserInformationError(response: SelectedUser.UserInformationError.Response)
    func presentUserDetails(response: SelectedUser.UserDetails.Response)
    func presentUserDetailsError(response: SelectedUser.UserDetailsError.Response)
}

class SelectedUserPresenter: SelectedUserPresentationLogic {

    weak var viewController: SelectedUserDisplayLogic?
    
    // MARK: Methods
    func presentUserInformation(response: SelectedUser.UserInformation.Response) {
        
        let user = response.selectedUser
        let name = "\(user.surname) \(user.name)"
        
        let viewModel = SelectedUser.UserInformation.ViewModel(name: name, email: user.email, phone: user.phone)
        viewController?.displayUserInformation(viewModel: viewModel)
    }
    
    func presentUserInformationError(response: SelectedUser.UserInformationError.Response) {
        
        let viewModel = SelectedUser.UserInformationError.ViewModel(error: response.error)
        viewController?.displayUserInformationError(viewModel: viewModel)
    }
    
    func presentUserDetails(response: SelectedUser.UserDetails.Response) {
        
        let viewModel = SelectedUser.UserDetails.ViewModel(photo: response.photo, posts: response.posts, thereAreTodos: response.thereAreTodos)
        viewController?.displayUserDetails(viewModel: viewModel)
    }
    
    func presentUserDetailsError(response: SelectedUser.UserDetailsError.Response) {
        
        let viewModel = SelectedUser.UserInformationError.ViewModel(error: response.error)
        viewController?.displayUserInformationError(viewModel: viewModel)
    }
}
