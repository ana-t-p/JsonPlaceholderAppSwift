//
//  HomePresenterTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class HomePresenterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: HomePresenter!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupHomePresenter()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupHomePresenter() {
        
        sut = HomePresenter()
    }
    
    // MARK: Test doubles
    class HomeDisplayLogicSpy: HomeDisplayLogic {
        
        var displayGetUserListCalled = false
        var displayGetUserListErrorCalled = false
        var displaySelectedUserCalled = false
        var displaySelectedUserErrorCalled = false
        
        func displayGetUserList(viewModel: Home.UsersResults.ViewModel) {
            
            displayGetUserListCalled = true
        }
        
        func displayGetUserListError(viewModel: Home.UsersResultsError.ViewModel) {
            
            displayGetUserListErrorCalled = true
        }
        
        func displaySelectedUser(viewModel: Home.SelectedUserResults.ViewModel) {
            
            displaySelectedUserCalled = true
        }
        
        func displaySelectedUserError(viewModel: Home.SelectedUserResultsError.ViewModel) {
            
            displaySelectedUserErrorCalled = true
        }
    }
    
    // MARK: Tests
    func testPresentGetUserList() {
        
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        let response = Home.UsersResults.Response(names: ["FakeName1", "FakeName2", "FakeName3"])
        
        // When
        sut.presentGetUserList(response: response)
        
        // Then
        XCTAssertTrue(spy.displayGetUserListCalled)
    }
    
    func testPresentGetUserListError() {
        
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        let response = Home.UsersResultsError.Response(error: "FakeError")
        
        // When
        sut.presentGetUserListError(response: response)
        
        // Then
        XCTAssertTrue(spy.displayGetUserListErrorCalled)
    }
    
    func testPresentSelectedUserDetail() {
        
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        let response = Home.SelectedUserResults.Response()
        
        // When
        sut.presentSelectedUserDetail(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySelectedUserCalled)
    }
    
    func testPresentSelectedUserDetailError() {
        
        // Given
        let spy = HomeDisplayLogicSpy()
        sut.viewController = spy
        let response = Home.SelectedUserResultsError.Response(error: "FakeError")
        
        // When
        sut.presentSelectedUserDetailError(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySelectedUserErrorCalled)
    }
}
