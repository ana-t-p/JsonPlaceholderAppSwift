//
//  TodoListViewControllerTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class TodoListViewControllerTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: TodoListViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        window = UIWindow()
        setupTodoListViewController()
    }
    
    override func tearDown() {
        
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupTodoListViewController() {
        
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "TodoList", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "TodoListViewController") as? TodoListViewController
    }
    
    func loadView() {
        
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    class TodoListBusinessLogicSpy: TodoListBusinessLogic {
        
        var doSetUserTodoListCalled = false
        
        func doSetUserTodoList(request: TodoList.UserTodoList.Request) {
            
            doSetUserTodoListCalled = true
        }
    }
    
    // MARK: Tests
    func testClose() {
        
        // Given
        let spy = TodoListBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        let nc = UINavigationController(rootViewController: UIViewController())
        nc.viewControllers.append(sut)
        
        // When
        sut.close(sut.closeButton ?? UIButton())
        waitUI()
        
        // Then
        XCTAssertNil(nc.presentedViewController)
    }
    
    func testNumberOfRowsInSection() {
        
        // Given
        let spy = TodoListBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.todos = [SingleTodo(done: true, text: "FakeTODO")]
        
        // When
        let numRows = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        waitUI()
        
        // Then
        XCTAssertEqual(numRows, sut.todos.count)
    }
    
    func testCellForRowAt() {
        
        // Given
        let spy = TodoListBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        let viewModel = TodoList.UserTodoList.ViewModel(name: "FakeName", todoList: [SingleTodo(done: true, text: "FakeTodo")])
        sut.displayUserTodoList(viewModel: viewModel)
        waitUI()
        
        // When
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TodoListTableViewCell
        cell?.setSelected(false, animated: false)
        
        // Then
        XCTAssertTrue(cell?.switcher.isOn ?? false)
        XCTAssertFalse(cell?.todoLabel.text?.isEmpty ?? true)
        
        // When
        cell?.prepareForReuse()
        
        // Then
        XCTAssertFalse(cell?.switcher.isOn ?? true)
        XCTAssertTrue(cell?.todoLabel.text?.isEmpty ?? false)
    }
    
    func testHeightForRowAt() {
        
        // Given
        let spy = TodoListBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        let height = sut.tableView(sut.tableView, heightForRowAt: IndexPath(row: 0, section: 0))
        waitUI()

        // Then
        XCTAssertEqual(height, UITableView.automaticDimension)
    }
    
    func testDisplayUserTodoListError() {
        
        // Given
        let spy = TodoListBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        
        // When
        let viewModel = TodoList.UserTodoListError.ViewModel(error: "FakeError")
        sut.displayUserTodoListError(viewModel: viewModel)
        waitUI()
        
        // Then
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is UIAlertController)
    }
}
