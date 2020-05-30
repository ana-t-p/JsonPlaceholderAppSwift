//
//  TodoListWorker.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 30/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

import UIKit

enum JSONPlaceholderAPITodoListResult {
    
    case success(data: TodoListConfiguration)
    case failure(error: Error)
}

typealias TodoListWorkerCompletionHandler = (_ data: JSONPlaceholderAPITodoListResult) -> Void


class TodoListWorker {}
