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
    func presentUserPosts(response: SelectedUser.UserPosts.Response)
    func presentUserPostsError(response: SelectedUser.UserPostsError.Response)
    func presentUserPhoto(response: SelectedUser.UserPhoto.Response)
    func presentUserPhotoError(response: SelectedUser.UserPhotoError.Response)
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
    
    func presentUserPosts(response: SelectedUser.UserPosts.Response) {
        
        let viewModel = SelectedUser.UserPosts.ViewModel(posts: response.posts)
        viewController?.displayUserPosts(viewModel: viewModel)
    }
    
    func presentUserPostsError(response: SelectedUser.UserPostsError.Response) {
        
        let viewModel = SelectedUser.UserPostsError.ViewModel(error: response.error)
        viewController?.displayUserPostsError(viewModel: viewModel)
    }
    
    func presentUserPhoto(response: SelectedUser.UserPhoto.Response) {
        
        let viewModel = SelectedUser.UserPhoto.ViewModel(photo: response.photo)
        viewController?.displayUserPhoto(viewModel: viewModel)
    }
    
    func presentUserPhotoError(response: SelectedUser.UserPhotoError.Response) {
        
        let viewModel = SelectedUser.UserPhotoError.ViewModel(error: response.error)
        viewController?.displayUserPhotoError(viewModel: viewModel)
    }
}
