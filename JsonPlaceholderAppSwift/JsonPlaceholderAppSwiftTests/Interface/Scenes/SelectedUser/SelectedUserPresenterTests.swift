//
//  SelectedUserPresenterTests.swift
//  JsonPlaceholderAppSwift
//
//  Created by Ana Tirado Pro on 31/05/2020.
//  Copyright (c) 2020 Ana Tirado Pro. All rights reserved.
//

@testable import JsonPlaceholderAppSwift
import XCTest

class SelectedUserPresenterTests: XCTestCase {
    
    // MARK: Subject under test
    var sut: SelectedUserPresenter!
    
    // MARK: Test lifecycle
    override func setUp() {
        
        super.setUp()
        setupSelectedUserPresenter()
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    // MARK: Test setup
    func setupSelectedUserPresenter() {
        
        sut = SelectedUserPresenter()
    }
    
    // MARK: Test doubles
    class SelectedUserDisplayLogicSpy: SelectedUserDisplayLogic {
        
        var displayUserInformationCalled = false
        var displayUserInformationErrorCalled = false
        var displayUserDetailsCalled = false
        var displayUserDetailsErrorCalled = false
        
        func displayUserInformation(viewModel: SelectedUser.UserInformation.ViewModel) {
            
            displayUserInformationCalled = true
        }
        
        func displayUserInformationError(viewModel: SelectedUser.UserInformationError.ViewModel) {
            
            displayUserInformationErrorCalled = true
        }
        
        func displayUserDetails(viewModel: SelectedUser.UserDetails.ViewModel) {
            
            displayUserDetailsCalled = true
        }
        
        func displayUserDetailsError(viewModel: SelectedUser.UserDetailsError.ViewModel) {
            
            displayUserDetailsErrorCalled = true
        }
    }
    
    // MARK: Tests
    func testPresentUserInformation() {
        
        // Given
        let spy = SelectedUserDisplayLogicSpy()
        sut.viewController = spy
        let response = SelectedUser.UserInformation.Response(selectedUser: ChoosenUser(id: 1, name: "FakeName", surname: "Surname", email: "FakeEmail", phone: "123456789"))
        
        // When
        sut.presentUserInformation(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserInformationCalled)
    }
    
    func testPresentUserInformationError() {
        
        // Given
        let spy = SelectedUserDisplayLogicSpy()
        sut.viewController = spy
        let response = SelectedUser.UserInformationError.Response(error: "FakeError")
        
        // When
        sut.presentUserInformationError(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserInformationErrorCalled)
    }
    
    func testPresentUserDetails() {
        
        // Given
        let spy = SelectedUserDisplayLogicSpy()
        sut.viewController = spy
        let response = SelectedUser.UserDetails.Response(photo: UIImage(), posts: ["FakePost"], thereAreTodos: true)
        
        // When
        sut.presentUserDetails(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserDetailsCalled)
    }
    
    func testPresentUserDetailsError() {
        
        // Given
        let spy = SelectedUserDisplayLogicSpy()
        sut.viewController = spy
        let response = SelectedUser.UserDetailsError.Response(error: "FakeError")
        
        // When
        sut.presentUserDetailsError(response: response)
        
        // Then
        XCTAssertTrue(spy.displayUserDetailsErrorCalled)
    }
}
