//
//  TodoListPresenterTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class TodoListPresenterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TodoListPresenter!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupTodoListPresenter()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTodoListPresenter() {
        
        sut = TodoListPresenter()
    }
    
    // MARK: Test doubles
    class TodoListDisplayLogicSpy: TodoListDisplayLogic {
        
        var displayUserTodoListCalled = false
        var displayUserTodoListErrorCalled = false
        
        func displayUserTodoList(viewModel: TodoList.UserTodoList.ViewModel) {
            
            displayUserTodoListCalled = true
        }
        
        func displayUserTodoListError(viewModel: TodoList.UserTodoListError.ViewModel) {
            
            displayUserTodoListErrorCalled = true
        }
    }
    
    // MARK: Tests
    func testPresentUserTodoList() {
        
        // Given
        let spy = TodoListDisplayLogicSpy()
        sut.viewController = spy
        let response = TodoList.UserTodoList.Response(name: "FakeName", todoList: [SingleTodo(done: true, text: "FakeTODO")])
        
        // When
        sut.presentUserTodoList(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserTodoListCalled)
    }
    
    func testPresentUserTodoListError() {
        
        // Given
        let spy = TodoListDisplayLogicSpy()
        sut.viewController = spy
        let response = TodoList.UserTodoListError.Response(error: "FakeError")
        
        // When
        sut.presentUserTodoListError(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserTodoListErrorCalled)
    }
}
