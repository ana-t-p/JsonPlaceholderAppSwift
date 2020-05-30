//
//  TodoListPresenter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol TodoListPresentationLogic {
    
    func presentSomething(response: TodoList.Something.Response)
}

class TodoListPresenter: TodoListPresentationLogic {
    
    weak var viewController: TodoListDisplayLogic?
    
    // MARK: Methods
    func presentSomething(response: TodoList.Something.Response) {
        
        let viewModel = TodoList.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
