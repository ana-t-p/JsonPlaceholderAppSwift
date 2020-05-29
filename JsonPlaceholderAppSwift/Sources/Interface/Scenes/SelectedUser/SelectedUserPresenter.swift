//
//  SelectedUserPresenter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 29/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol SelectedUserPresentationLogic {
    
    func presentSomething(response: SelectedUser.Something.Response)
}

class SelectedUserPresenter: SelectedUserPresentationLogic {
    
    weak var viewController: SelectedUserDisplayLogic?
    
    // MARK: Methods
    func presentSomething(response: SelectedUser.Something.Response) {
        
        let viewModel = SelectedUser.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
