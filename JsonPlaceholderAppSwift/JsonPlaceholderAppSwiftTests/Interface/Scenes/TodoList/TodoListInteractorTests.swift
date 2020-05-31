//
//  TodoListInteractorTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class TodoListInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TodoListInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        
        super.setUp()
        setupTodoListInteractor()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTodoListInteractor() {
        
        sut = TodoListInteractor()
    }
    
    // MARK: Test doubles
    class TodoListPresentationLogicSpy: TodoListPresentationLogic {
        
        var presentUserTodoListCalled = false
        var presentUserTodoListErrorCalled = false
        
        func presentUserTodoList(response: TodoList.UserTodoList.Response) {
            
            presentUserTodoListCalled = true
        }
        
        func presentUserTodoListError(response: TodoList.UserTodoListError.Response) {
            
            presentUserTodoListErrorCalled = true
        }
    }
    
    // MARK: Tests
    func testDoSetUserTodoList() {
        
        // Given
        let spy = TodoListPresentationLogicSpy()
        sut.presenter = spy
        sut.name = "FakeName"
        sut.todoList = [SingleTodo(done: true, text: "FakeTODO")]
        let request = TodoList.UserTodoList.Request()
        
        // When
        sut.doSetUserTodoList(request: request)
        
        // Then
        XCTAssertTrue(spy.presentUserTodoListCalled)
        
        // When
        sut.todoList = nil
        sut.doSetUserTodoList(request: request)
        
        // Then
        XCTAssertTrue(spy.presentUserTodoListErrorCalled)
    }
}
