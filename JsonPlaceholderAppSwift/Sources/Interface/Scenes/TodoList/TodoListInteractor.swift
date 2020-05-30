//
//  TodoListInteractor.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

protocol TodoListBusinessLogic {
    func doSomething(request: TodoList.Something.Request)
}

protocol TodoListDataStore {
    //var name: String { get set }
}

class TodoListInteractor: TodoListBusinessLogic, TodoListDataStore {
    
    var presenter: TodoListPresentationLogic?
    var worker: TodoListWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: TodoList.Something.Request) {
        
        worker = TodoListWorker()
        worker?.doSomeWork()
        
        let response = TodoList.Something.Response()
        presenter?.presentSomething(response: response)
    }
}
