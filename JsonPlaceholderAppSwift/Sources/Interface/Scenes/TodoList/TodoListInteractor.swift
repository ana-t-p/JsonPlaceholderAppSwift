//
//  TodoListInteractor.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol TodoListBusinessLogic {
    
    func doSetUserTodoList(request: TodoList.UserTodoList.Request)
}

protocol TodoListDataStore {
    
    var name: String? { get set }
    var todoList: [SingleTodo]? { get set }
}

class TodoListInteractor: TodoListBusinessLogic, TodoListDataStore {
    
    var presenter: TodoListPresentationLogic?
    var worker: TodoListWorker?
    var name: String?
    var todoList: [SingleTodo]?
    
    // MARK: Methods
    func doSetUserTodoList(request: TodoList.UserTodoList.Request) {
        
        if let name = name, let todoList = todoList {
            
            let response = TodoList.UserTodoList.Response(name: name, todoList: todoList)
            presenter?.presentUserTodoList(response: response)
        } else {
            
            let response = TodoList.UserTodoListError.Response(error: ErrorCases.apiCalling.localizedDescription)
            presenter?.presentUserTodoListError(response: response)
        }
    }
}
