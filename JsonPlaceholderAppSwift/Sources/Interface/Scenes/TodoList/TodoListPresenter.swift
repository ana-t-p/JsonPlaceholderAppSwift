//
//  TodoListPresenter.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol TodoListPresentationLogic {
    
    func presentUserTodoList(response: TodoList.UserTodoList.Response)
    func presentUserTodoListError(response: TodoList.UserTodoListError.Response)
}

class TodoListPresenter: TodoListPresentationLogic {
    
    weak var viewController: TodoListDisplayLogic?
    
    // MARK: Methods
    func presentUserTodoList(response: TodoList.UserTodoList.Response) {
        
        let viewModel = TodoList.UserTodoList.ViewModel(todoList: response.todoList)
        viewController?.displayUserTodoList(viewModel: viewModel)
    }
    
    func presentUserTodoListError(response: TodoList.UserTodoListError.Response) {
        
        let viewModel = TodoList.UserTodoListError.ViewModel(error: response.error)
        viewController?.displayUserTodoListError(viewModel: viewModel)
    }
}
