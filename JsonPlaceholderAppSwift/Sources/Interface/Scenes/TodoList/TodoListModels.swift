//
//  TodoListModels.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

struct SingleTodo {
    
    var done: Bool
    var text: String
}

struct TodoListConfiguration {
    
    var todoList: [SingleTodo]?
}

struct TodoList {
    
    struct UserTodoList {
        
        struct Request {}
        
        struct Response {
            
            var todoList: [SingleTodo]
        }
        
        struct ViewModel {
            
            var todoList: [SingleTodo]
        }
    }
    
    struct UserTodoListError {
        
        struct Request {}
        
        struct Response {
            
            var error: String
        }
        
        struct ViewModel {
            
            var error: String
        }
    }
}
