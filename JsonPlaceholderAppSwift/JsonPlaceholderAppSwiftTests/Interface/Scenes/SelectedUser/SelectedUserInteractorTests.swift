//
//  SelectedUserInteractorTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class SelectedUserInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: SelectedUserInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        
        super.setUp()
        setupSelectedUserInteractor()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupSelectedUserInteractor() {
        
        sut = SelectedUserInteractor()
    }
    
    // MARK: Test doubles
    class SelectedUserPresentationLogicSpy: SelectedUserPresentationLogic, SelectedUserDataStore {
        
        var selectedUser: ChoosenUser?
        var name: String? = "FakeName"
        var todoList: [SingleTodo]? = [SingleTodo(done: true, text: "FakeTODO")]

        var presentUserInformationCalled = false
        var presentUserInformationErrorCalled = false
        var presentUserDetailsCalled = false
        var presentUserDetailsErrorCalled = false
        
        func presentUserInformation(response: SelectedUser.UserInformation.Response) {
            
            presentUserInformationCalled = true
        }
        
        func presentUserInformationError(response: SelectedUser.UserInformationError.Response) {
            
            presentUserInformationErrorCalled = true
        }
        
        func presentUserDetails(response: SelectedUser.UserDetails.Response) {
            
            presentUserDetailsCalled = true
        }
        
        func presentUserDetailsError(response: SelectedUser.UserDetailsError.Response) {
            
            presentUserDetailsErrorCalled = true
        }
    }
    
    class SelectedUserWorkerSpy: SelectedUserWorker {
       
        override func getSelectedUserDetails(_ id: Int, result: @escaping (PhotoConfiguration?, PostsConfiguration?, TodoListConfiguration?, String) -> Void) {
            
            let photo = PhotoConfiguration(photo: UIImage())
            let posts = PostsConfiguration(bodies: ["FakePost"])
            let todos = TodoListConfiguration(todoList: [SingleTodo(done: true, text: "FakeTODO")])
            result(photo, posts, todos, "")
        }
    }
    
    // MARK: Tests
    func testDoSetUserInformation() {
        
        // Given
        let spy = SelectedUserPresentationLogicSpy()
        sut.presenter = spy
        sut.selectedUser = ChoosenUser(id: 1, name: "FakeName", surname: "FakeSurname", email: "FakeEmail", phone: "123456789")
        
        // When
        let request = SelectedUser.UserInformation.Request()
        sut.doSetUserInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentUserInformationCalled)
        
        // When
        sut.selectedUser = nil
        sut.doSetUserInformation(request: request)
        
        // Then
        XCTAssertTrue(spy.presentUserInformationErrorCalled)
    }
    
    func testDoGetUserDetails() {
        
        // Given
        let spy = SelectedUserPresentationLogicSpy()
        sut.presenter = spy
        sut.worker = SelectedUserWorkerSpy()
        sut.selectedUser = ChoosenUser(id: 1, name: "FakeName", surname: "FakeSurname", email: "FakeEmail", phone: "123456789")
        
        // When
        let request = SelectedUser.UserDetails.Request()
        sut.doGetUserDetails(request: request)
        
        // Then
        XCTAssertTrue(spy.presentUserDetailsCalled)
        
        // When
        sut.selectedUser = nil
        sut.doGetUserDetails(request: request)
        
        // Then
        XCTAssertTrue(spy.presentUserDetailsErrorCalled)
    }
}
