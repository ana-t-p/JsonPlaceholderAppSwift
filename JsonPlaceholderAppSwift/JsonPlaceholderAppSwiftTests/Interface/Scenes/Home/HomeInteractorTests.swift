//
//  HomeInteractorTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class HomeInteractorTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: HomeInteractor!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupHomeInteractor()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomeInteractor() {
        
        sut = HomeInteractor()
    }
    
    // MARK: Test doubles
    class HomePresentationLogicSpy: HomePresentationLogic {
        
        var presentGetUserListCalled = false
        var presentGetUserListErrorCalled = false
        var presentSelectedUserDetailCalled = false
        var presentSelectedUserDetailErrorCalled = false
        
        func presentGetUserList(response: Home.UsersResults.Response) {
            
            presentGetUserListCalled = true
        }
        
        func presentGetUserListError(response: Home.UsersResultsError.Response) {
            
            presentGetUserListErrorCalled = true
        }
        
        func presentSelectedUserDetail(response: Home.SelectedUserResults.Response) {
            
            presentSelectedUserDetailCalled = true
        }
        
        func presentSelectedUserDetailError(response: Home.SelectedUserResultsError.Response) {
            
            presentSelectedUserDetailErrorCalled = true
        }
    }
    
    class HomeWorkerSpy: HomeWorker {
       
        override func getUserList(result: @escaping HomeWorkerCompletionHandler) {
            
            let data = UserConfiguration(users: [ChoosenUser(id: 1, name: "FakeName", surname: "FakeSurname", email: "FakeEmail", phone: "123456789")])
            result(JSONPlaceholderAPIUserResult.success(data: data))
        }
    }
    
    // MARK: Tests
    func testDoGetUserList() {
        
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        let workerSpy = HomeWorkerSpy()
        sut.worker = workerSpy
        
        // When
        sut.doGetUserList()

        // Then
        XCTAssertTrue(spy.presentGetUserListCalled)
    }
    
    func testDoGoToSelectedUser() {
        
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        sut.users = [ChoosenUser(id: 1, name: "FakeName", surname: "FakeSurname", email: "FakeEmail", phone: "123456789")]
        let request = Home.SelectedUserResults.Request(id: 1)
        
        // When
        sut.doGoToSelectedUser(request: request)
        
        // Then
        XCTAssertTrue(spy.presentSelectedUserDetailCalled)
    }
    
    func testDoGoToSelectedUserError() {
        
        // Given
        let spy = HomePresentationLogicSpy()
        sut.presenter = spy
        let request = Home.SelectedUserResults.Request(id: 1)
        
        // When
        sut.doGoToSelectedUser(request: request)
        
        // Then
        XCTAssertTrue(spy.presentSelectedUserDetailErrorCalled)
    }
}
