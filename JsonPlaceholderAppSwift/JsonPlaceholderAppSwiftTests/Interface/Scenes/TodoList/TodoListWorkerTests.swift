//
//  TodoListWorkerTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class TodoListWorkerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TodoListWorker!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupTodoListWorker()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTodoListWorker() {
        
        sut = TodoListWorker()
    }
}
